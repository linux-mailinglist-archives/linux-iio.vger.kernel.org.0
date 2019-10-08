Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787F3CF336
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfJHHGv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 03:06:51 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:53859 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbfJHHGv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 03:06:51 -0400
Received: (qmail 12789 invoked by uid 5089); 8 Oct 2019 07:06:48 -0000
Received: by simscan 1.2.0 ppid: 12709, pid: 12710, t: 0.0737s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 8 Oct 2019 07:06:48 -0000
Subject: Re: [PATCH v2 2/2] iio: core: Add optional symbolic label to device
 attributes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com
References: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
 <1568903768-65998-3-git-send-email-preid@electromag.com.au>
 <20191005155905.7fe1681e@archlinux> <20191007213244.2ed85c99@archlinux>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <34a7ab42-1e07-8c20-11ab-8e2a9dd2e74b@electromag.com.au>
Date:   Tue, 8 Oct 2019 15:06:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191007213244.2ed85c99@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/10/2019 04:32, Jonathan Cameron wrote:
> On Sat, 5 Oct 2019 15:59:05 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Thu, 19 Sep 2019 22:36:08 +0800
>> Phil Reid <preid@electromag.com.au> wrote:
>>
>>> If a label is defined in the device tree for this device add that
>>> to the device specific attributes. This is useful for userspace to
>>> be able to identify an individual device when multiple identical
>>> chips are present in the system.
>>>
>>> Tested-by: Michal Simek <michal.simek@xilinx.com>
>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>>
>> Glad to see this going in given I thought I'd already applied it
>> and told someone they should be using it early today (oops ;)
>>
>> Applied to the togreg branch of iio.git and pushed out as testing
>> for the autobuilders to play with it.
> 
> 0-day picked up that there were no docs for this new field.
> I've added some and re pushed out.

Thanks.
Just for my info what should I be doing to check for that.
Don't remember getting any warnings for that.


> 
> Thanks,
> 
> Jonathan
> 
>>
>> Thanks for doing this.
>>
>> Jonathan
>>
>>> ---
>>>   drivers/iio/industrialio-core.c | 17 +++++++++++++++++
>>>   include/linux/iio/iio.h         |  1 +
>>>   2 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>> index 524a686077ca..f72c2dc5f703 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -1238,6 +1238,16 @@ static ssize_t iio_show_dev_name(struct device *dev,
>>>   
>>>   static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
>>>   
>>> +static ssize_t iio_show_dev_label(struct device *dev,
>>> +				 struct device_attribute *attr,
>>> +				 char *buf)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> +	return snprintf(buf, PAGE_SIZE, "%s\n", indio_dev->label);
>>> +}
>>> +
>>> +static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
>>> +
>>>   static ssize_t iio_show_timestamp_clock(struct device *dev,
>>>   					struct device_attribute *attr,
>>>   					char *buf)
>>> @@ -1354,6 +1364,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>>>   
>>>   	if (indio_dev->name)
>>>   		attrcount++;
>>> +	if (indio_dev->label)
>>> +		attrcount++;
>>>   	if (clk)
>>>   		attrcount++;
>>>   
>>> @@ -1376,6 +1388,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>>>   		indio_dev->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
>>>   	if (indio_dev->name)
>>>   		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
>>> +	if (indio_dev->label)
>>> +		indio_dev->chan_attr_group.attrs[attrn++] = &dev_attr_label.attr;
>>>   	if (clk)
>>>   		indio_dev->chan_attr_group.attrs[attrn++] = clk;
>>>   
>>> @@ -1647,6 +1661,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>>>   	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>>>   		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>>>   
>>> +	indio_dev->label = of_get_property(indio_dev->dev.of_node, "label",
>>> +					   NULL);
>>> +
>>>   	ret = iio_check_unique_scan_index(indio_dev);
>>>   	if (ret < 0)
>>>   		return ret;
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index 8e132cf819e4..a2527c7ab934 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -553,6 +553,7 @@ struct iio_dev {
>>>   	struct list_head		channel_attr_list;
>>>   	struct attribute_group		chan_attr_group;
>>>   	const char			*name;
>>> +	const char			*label;
>>>   	const struct iio_info		*info;
>>>   	clockid_t			clock_id;
>>>   	struct mutex			info_exist_lock;
>>
> 
> 
> 


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
