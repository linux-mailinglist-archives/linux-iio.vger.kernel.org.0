Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7528160040
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 20:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgBOTnJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 14:43:09 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:46442 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgBOTnJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 14:43:09 -0500
Received: from [192.168.1.106] (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 36C6A251A5;
        Sat, 15 Feb 2020 20:43:05 +0100 (CET)
Date:   Sat, 15 Feb 2020 20:42:59 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v5 6/7] iio: light: al3320a implement
 devm_add_action_or_reset
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
Message-Id: <1581795779.188492.1@ixit.cz>
In-Reply-To: <20200215183825.77bda8a8@archlinux>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-7-david@ixit.cz> <20200215183825.77bda8a8@archlinux>
X-Mailer: geary/3.35.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you for fixes, it does look good.
Only thing is fixes which should go into commit "iio: light: al3320a 
implement suspend support"[1] when into "iio: light: al3320a implement 
devm_add_action_or_reset" [2].

+ return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG, val);

and

+static SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend, 
al3320a_resume);


Thank you very much for merging and next time
I'll spend more time with review and doing final build test.

David

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=d74856400b2dcb2e0eab2132c779408809566431
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=4b1b42bcd993258628fabc5e35f20a202b1e9f7b


On Sat, Feb 15, 2020 at 18:38, Jonathan Cameron <jic23@kernel.org> 
wrote:
> On Tue, 11 Feb 2020 20:12:00 +0100
> David Heidelberg <david@ixit.cz> wrote:
> 
>>  Use devm_add_action_or_reset to automatically disable the device
>>  and allow you to get rid of the remove function entirely.
>> 
>>  Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> This doesn't build as is.  I've fixed up but please take a close
> look at the result.
> 
>>  ---
>>   drivers/iio/light/al3320a.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>> 
>>  diff --git a/drivers/iio/light/al3320a.c 
>> b/drivers/iio/light/al3320a.c
>>  index affa4c6c199a..49e73e24fff6 100644
>>  --- a/drivers/iio/light/al3320a.c
>>  +++ b/drivers/iio/light/al3320a.c
>>  @@ -87,6 +87,13 @@ static int al3320a_set_pwr(struct i2c_client 
>> *client, bool pwr)
>>   	return i2c_smbus_write_byte_data(data->client, 
>> AL3320A_REG_CONFIG, val);
>>   }
>> 
>>  +static void al3320a_set_pwr_off(void *_data)
>>  +{
>>  +	struct al3320a_data *data = _data;
>>  +
>>  +	al3320a_set_pwr(data->client, false);
>>  +}
>>  +
>>   static int al3320a_init(struct al3320a_data *data)
>>   {
>>   	int ret;
>>  @@ -206,12 +213,14 @@ static int al3320a_probe(struct i2c_client 
>> *client,
>>   		dev_err(&client->dev, "al3320a chip init failed\n");
>>   		return ret;
>>   	}
>>  -	return devm_iio_device_register(&client->dev, indio_dev);
>>  -}
>> 
>>  -static int al3320a_remove(struct i2c_client *client)
>>  -{
>>  -	return al3320a_set_pwr(client, false);
>>  +	ret = devm_add_action_or_reset(&client->dev,
>>  +					al3320a_set_pwr_off,
>>  +					data);
>>  +	if (ret < 0)
>>  +		return ret;
>>  +
>>  +	return devm_iio_device_register(&client->dev, indio_dev);
>>   }
>> 
>>   static int __maybe_unused al3320a_suspend(struct device *dev)
>>  @@ -238,7 +247,6 @@ static struct i2c_driver al3320a_driver = {
>>   		.pm = &al3320a_pm_ops,
>>   	},
>>   	.probe		= al3320a_probe,
>>  -	.remove		= al3320a_remove,
>>   	.id_table	= al3320a_id,
>>   };
>> 
> 


