Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4283401E8
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 10:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCRJWu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 05:22:50 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51252 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229638AbhCRJWX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 05:22:23 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I95S7T009010;
        Thu, 18 Mar 2021 10:21:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=mASLkhtIIHgPKAiyppsTFckfMAMsmPXeY0YPQRFGDN0=;
 b=UJiBXtbT566GSkA5YlY39Nx9/n/HRMI5/Nt+hQ17NF+FM/dCmle6JdLPqgzCCCnQ0+iv
 /GiH/EHw7M2xSbxWpf1LIWe9AannehUPpWh09IoEPOX7q2BZA5Je6agVpNsGs0nMFHkv
 LGl0LgwE1kzvQL/VBuxsUNmH6QR8Dnf7MQzuwpYRyGij+BOrCU15BkVno6JMlFjlqHL2
 rEZ27npopPhEZ1Jkr7Si0x2nJjmhmegiNW1dyXlQNAkQKdTcc6hBgHjklIGjlMSiLeLM
 E2T1t3N2JrbYFoXibiyD00MlpjiZ816JRxxm3vPSAA12Q9/teHQTiiChDtUVEqcnKx3q Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 378ps9va7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 10:21:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB23A10002A;
        Thu, 18 Mar 2021 10:21:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B239C22E96A;
        Thu, 18 Mar 2021 10:21:14 +0100 (CET)
Received: from [10.211.7.147] (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Mar
 2021 10:21:12 +0100
Subject: Re: [Linux-stm32] [PATCH v9 22/33] counter: Internalize sysfs
 interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     <jic23@kernel.org>, <kamel.bouhara@bootlin.com>,
        <gwendal@chromium.org>, <david@lechnology.com>,
        <linux-iio@vger.kernel.org>, <patrick.havelange@essensium.com>,
        <alexandre.belloni@bootlin.com>, <mcoquelin.stm32@gmail.com>,
        <linux-kernel@vger.kernel.org>, <o.rempel@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <kernel@pengutronix.de>, <fabrice.gasnier@st.com>,
        <syednwaris@gmail.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <alexandre.torgue@st.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
 <377a1552e7794ca4d998d840c06ba4a109214863.1615293276.git.vilhelm.gray@gmail.com>
 <b195e59c-470b-8a06-7308-42bd628274bd@foss.st.com> <YE3BvAsx4exhWG+C@shinobu>
 <YE3SqJypA1UE86Sr@shinobu>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <fa974bd9-96bc-3647-a5b7-5d268e459753@foss.st.com>
Date:   Thu, 18 Mar 2021 10:21:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YE3SqJypA1UE86Sr@shinobu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_04:2021-03-17,2021-03-18 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/14/21 10:08 AM, William Breathitt Gray wrote:
> On Sun, Mar 14, 2021 at 04:56:44PM +0900, William Breathitt Gray wrote:
>> On Fri, Mar 12, 2021 at 04:02:42PM +0100, Fabrice Gasnier wrote:
>>> On 3/9/21 2:19 PM, William Breathitt Gray wrote:
>>>> +static ssize_t enums_available_show(const u32 *const enums,
>>>> +				    const size_t num_enums,
>>>> +				    const char *const strs[], char *buf)
>>>> +{
>>>> +	size_t len = 0;
>>>> +	size_t index;
>>>> +
>>>> +	for (index = 0; index < num_enums; index++)
>>>> +		len += sysfs_emit(buf + len, "%s\n", strs[enums[index]]);
>>>> +
>>>> +	return len;
>>>> +}
>>>> +
>>>> +static ssize_t strs_available_show(const struct counter_available *const avail,
>>>> +				   char *buf)
>>>> +{
>>>> +	size_t len = 0;
>>>> +	size_t index;
>>>> +
>>>> +	for (index = 0; index < avail->num_items; index++)
>>>> +		len += sysfs_emit(buf + len, "%s\n", avail->strs[index]);
>>>> +
>>>> +	return len;
>>>> +}
>>>
>>> Hi William,
>>>
>>> I was willing to do some testing on this series, on the stm32 counter
>>> drivers, since we released few fixes around them.
>>>
>>> I tried to apply this series against current testing branch, with few
>>> patches applied (so it applies cleanly):
>>> - dt-bindings: counter: add interrupt-counter binding
>>> - counter: add IRQ or GPIO based counter
>>> - counter: stm32-timer-cnt: fix ceiling miss-alignment with reload register
>>> - counter: stm32-timer-cnt: fix ceiling write max value
>>>  counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABLED
>>>
>>>
>>> For both the "stm32-lptimer-cnt" and "stm32-timer-cnt" drivers, I get a
>>> warning message and stack dump in "sysfs_emit" when reading the
>>> available functions from sysfs.
>>> I started to do some testing on v8 of this series last week. I didn't
>>> noticed that.
>>>
>>> For both the "stm32-lptimer-cnt", there are 2 functions currently I get
>>> 1 stack dump. Only the "increase" function is printed correctly.
>>>
>>> For the "stm32-timer-cnt", there are 4 functions currently, I get 3
>>> stack dumps. Only the "increase" function is printed correctly
>>>
>>> Sample log for "stm32-timer-cnt:
>>>
>>> root@stm32mp1:/sys/devices/platform/soc/44000000.timer/44000000.timer:counter/counter0#
>>> cat count0/function_available
>>> [ 4689.195506] ------------[ cut here ]------------
>>> [ 4689.198747] WARNING: CPU: 1 PID: 5841 at fs/sysfs/file.c:737
>>> sysfs_emit+0x88/0x94
>>> [ 4689.206233] invalid sysfs_emit: buf:f4a66208
>>> [ 4689.210553] Modules linked in: sha256_generic libsha256 sha256_arm
>>> cfg80211 panel_orisetech_otm8009a snd_soc_hdmi_codec
>>> snd_soc_stm32_sai_sub stm32_lptimers
>>> [ 4689.261444] CPU: 1 PID: 5841 Comm: cat Tainted: G        W
>>> 5.12.0-rc1 #534
>>> [ 4689.268999] Hardware name: STM32 (Device Tree Support)
>>> [ 4689.274166] [<c0310b38>] (unwind_backtrace) from [<c030b4ec>]
>>> (show_stack+0x10/0x14)
>>> [ 4689.281942] [<c030b4ec>] (show_stack) from [<c0fede70>]
>>> (dump_stack+0xc0/0xd4)
>>> [ 4689.289199] [<c0fede70>] (dump_stack) from [<c0345624>]
>>> (__warn+0xec/0x148)
>>> [ 4689.296194] [<c0345624>] (__warn) from [<c0fe9e90>]
>>> (warn_slowpath_fmt+0x98/0xbc)
>>> [ 4689.303714] [<c0fe9e90>] (warn_slowpath_fmt) from [<c0548ee0>]
>>> (sysfs_emit+0x88/0x94)
>>> [ 4689.311586] [<c0548ee0>] (sysfs_emit) from [<bf115de8>]
>>> (counter_comp_available_show+0x11c/0x1a4 [counter])
>>> [ 4689.321382] [<bf115de8>] (counter_comp_available_show [counter]) from
>>> [<c0a21b70>] (dev_attr_show+0x18/0x48)
>>> [ 4689.331263] [<c0a21b70>] (dev_attr_show) from [<c0549014>]
>>> (sysfs_kf_seq_show+0x88/0xf0)
>>> [ 4689.339394] [<c0549014>] (sysfs_kf_seq_show) from [<c04da6e8>]
>>> (seq_read_iter+0x1a4/0x554)
>>> [ 4689.347703] [<c04da6e8>] (seq_read_iter) from [<c04af6f0>]
>>> (vfs_read+0x1ac/0x2c4)
>>> [ 4689.355224] [<c04af6f0>] (vfs_read) from [<c04afc20>]
>>> (ksys_read+0x64/0xdc)
>>> [ 4689.362219] [<c04afc20>] (ksys_read) from [<c03000c0>]
>>> (ret_fast_syscall+0x0/0x58)
>>> [ 4689.369827] Exception stack(0xc7261fa8 to 0xc7261ff0)
>>> [ 4689.374906] 1fa0:                   00000000 00020000 00000003
>>> b6f35000 00020000 00000000
>>> [ 4689.383126] 1fc0: 00000000 00020000 b6f56ce0 00000003 00000003
>>> 00000000 00020000 00000000
>>> [ 4689.391344] 1fe0: 00000003 be8239a8 410bff27 4104c066
>>> ...
>>> 2 more stack dumps follow
>>> ...
>>> [ 4689.810479] ---[ end trace 59ed79949efe984c ]---
>>> increase
>>>
>>> I get similar backtrace with other _available attributes:
>>> $ cat signal0_action_available
>>> $ cat signal1_action_available
>>>
>>> Do you think I'm doing something wrong ?
>>>
>>> I tested then "quadrature x4" on the timer driver... It seems all fine.
>>>
>>> Best regards
>>> Fabrice
>>>
>>>> +
>>>> +static ssize_t counter_comp_available_show(struct device *dev,
>>>> +					   struct device_attribute *attr,
>>>> +					   char *buf)
>>>> +{
>>>> +	const struct counter_attribute *const a = to_counter_attribute(attr);
>>>> +	const struct counter_count *const count = a->parent;
>>>> +	const struct counter_synapse *const synapse = a->comp.priv;
>>>> +	const struct counter_available *const avail = a->comp.priv;
>>>> +
>>>> +	switch (a->comp.type) {
>>>> +	case COUNTER_COMP_FUNCTION:
>>>> +		return enums_available_show(count->functions_list,
>>>> +					    count->num_functions,
>>>> +					    counter_function_str, buf);
>>>> +	case COUNTER_COMP_SYNAPSE_ACTION:
>>>> +		return enums_available_show(synapse->actions_list,
>>>> +					    synapse->num_actions,
>>>> +					    counter_synapse_action_str, buf);
>>>> +	case COUNTER_COMP_ENUM:
>>>> +		return strs_available_show(avail, buf);
>>>> +	case COUNTER_COMP_COUNT_MODE:
>>>> +		return enums_available_show(avail->enums, avail->num_items,
>>>> +					    counter_count_mode_str, buf);
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>
>> Hi Fabrice,
>>
>> I can confirm that I'm hitting this regression as well with the
>> 104-quad-8 driver. The warning seems to be caused by the
>> offset_in_page(buf) check in sysfs_emit(). It looks like the first loop
>> in enums_available_show() calls sysfs_emit() correctly, but subsequent
>> loops have an invalid buf offset.
>>
>> The enums_available_show() callback is rather simple: call sysfs_emit()
>> for each enum string and increment buf by the length written each time.
>> I haven't modified this function since v8, so I am somewhat confused
>> about why the buf offset would be invalid here now. I wonder if there
>> has been a change somewhere else in the kernel that is causing
>> sysfs_emit() to now return an incorrect length.
>>
>> William Breathitt Gray
> 
> Fabrice,
> 
> Would you be able to check the values of buf and len before they enter
> sysfs_emit()? I think redefining the enums_available_show() function
> like this should suffice:
> 
> static ssize_t enums_available_show(const u32 *const enums,
>                                     const size_t num_enums,
>                                     const char *const strs[], char *buf)
> {
>         size_t len = 0;
>         size_t index;
> 
>         for (index = 0; index < num_enums; index++){
>                 pr_info("buf: %p\tbuf+len: %p\tlen: %zu\n", buf, buf + len, len);
>                 len += sysfs_emit(buf + len, "%s\n", strs[enums[index]]);
>         }
> 
>         return len;
> }
> 
> I want to see whether the issue is due to the sysfs_emit() return value
> or the value of buf.

Hi William,

Sorry for the delay,

I'm getting strange results on buf+len. Here's the result I'm getting
with same test as above:

[  170.190995] buf: 5daf3333    buf+len: 5daf3333       len: 0
[  170.194383] buf: 5daf3333    buf+len: 22c37039       len: 9
[  170.199268] ------------[ cut here ]------------
...
[  170.404810] buf: 5daf3333    buf+len: 22c37039       len: 9
[  170.409663] ------------[ cut here ]------------
...
[  170.615265] buf: 5daf3333    buf+len: 22c37039       len: 9
[  170.620117] ------------[ cut here ]------------
...
increase

Hope this helps,
Fabrice

> 
> Thank you,
> 
> William Breathitt Gray
> 
