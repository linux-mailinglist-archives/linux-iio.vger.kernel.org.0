Return-Path: <linux-iio+bounces-6711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4CD9133D6
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0079B1C20DC1
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA0016B398;
	Sat, 22 Jun 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW3p9yKu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07D16A936;
	Sat, 22 Jun 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058571; cv=none; b=HjNjfE8xB60ERmD44y5KmdxPg1DUZYOqEDbKiNzauLnoqwYJkx9OYh8AAxrPpmSMjn21IssmSjPSnW7MlRiVorA/msHXZvSAz/Tc/NTtc0L5Tg9OQtH5gfa+cyy3/Tmy5tzunhXf6GDFuggRvlZVqSYUxbX3ev8Ia87KBFAIuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058571; c=relaxed/simple;
	bh=z598XMD842ztuCUg+IpoAI72MGdv5YAoUX9Qhbrr3xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciwpzoCR+HgTRjcOt79QkBEO7tRgqwesaTOddDALKqTeJldRHIZztPSPKEVR9TIeyxKpYQv2KsqRcI36RMAUr03/lIIJNkP9Y9WURnUh6kgafkedzLzv6K+dTe/H5rXyopfz2DIbRvru8NfBIFagh4IPpCCMfxEiEWbqQ484EPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW3p9yKu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70666ab6434so420245b3a.1;
        Sat, 22 Jun 2024 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719058546; x=1719663346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3W3G2Rb6vvlDZn2Jk41CpbVovEcLzAmKsgPYCjhgKNE=;
        b=OW3p9yKuumGBjQZNr+Aoo8NxrC94lTvlaTl3mLlQA5CauKadnsTVCgfnuxObab2Cay
         bwYoDozWFjoMg+us9QdhamX4Y1D9eqCuzPV20sjy0bwjd8C1ahQ+tVHreSRurFb4Uf5e
         18R4Xx8Jjun1sPVBd3wpStLkrUNTGWrgG/CC1gvZUpgvPZGm1icq36Cmqqz0kmJnQCXp
         wIbo/vzAEHryCzJT1JfwMb60C9+K/j1/UpbthpgXPwfyoljqenv+2Fvx9IFatxlqLybY
         ZHsT0IgWe23pjfqjaE1PooToOK+pjCxDMuRoyRt6QgzTb3PQiXhV1w38my3TCwnRoARp
         djhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719058546; x=1719663346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3W3G2Rb6vvlDZn2Jk41CpbVovEcLzAmKsgPYCjhgKNE=;
        b=URKrK4Ace/13USFa+QMwHV7O6iAas++gSqyo1Oe793qRPPqjtPrM/u99uzRnteIdlK
         FSz+h8rh9FT9sKJswq5weBj+ofnAtqN6sHZBBFpMBcStL3HcuScr4GHKehYozAFShnDZ
         v4PZJanSkEH/njYJU3VaohudSQnKQy5bZTYudUvsCAObagoeYnP+Qchm3AQQKcAO2oDj
         nT+7Y8gDNIA3MlXBXprrq9jUZpX6BmWWz8hXSUOEO9n49SDMdaDVoFdscfKtqiOF9+Lj
         63/L/hQYLZhWTBK9CBYxhTwRgdrnTucP9hoJv83Y51e/wCWl5l96zC9OL+uQn3JeR7kK
         wx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyCoHpm2BVuwfn6xH0EwXXKef5kVUyq2V6MFLD4jxX2hKhH+MrlGTX7v1DH/qrx20nnYvZvDqkTyDn3CrOl2PfTw8HaR4xdNUTV7LgQZD/+3KOLb/1L7zNzL7WsVu0230nNNSyhtGpySeQvdgTH3luuT5U2rVWNiMioX/9X7y6/bCkSg==
X-Gm-Message-State: AOJu0YyjUcCwNCtHImeIfCgIOuBr8Y2yjBv6+9JxI4stX0BScrTYEDdT
	5HIagd7h4PU605AWbfoHAP8JTGqOhaK8k/tpyhas0lNe4xiFtNo4
X-Google-Smtp-Source: AGHT+IFbQVzrY+9rZahYg59axODYHfzUIo+WWxv90us6DXUX/bS4UneupF6Rio7WO2iFFMsRf9vzOA==
X-Received: by 2002:a05:6a00:138f:b0:705:d8b8:682d with SMTP id d2e1a72fcca58-70670fd21e5mr359060b3a.22.1719058546128;
        Sat, 22 Jun 2024 05:15:46 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651269a92sm2962817b3a.105.2024.06.22.05.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 05:15:45 -0700 (PDT)
Message-ID: <e57153bb-3bf2-46da-bb1f-7cccea105ce2@gmail.com>
Date: Sat, 22 Jun 2024 20:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
 <20240621-add-tyhx-hx9023s-sensor-driver-v6-3-65196a9020f1@gmail.com>
 <CA+GgBR8ojL-TT89y_=SvaidfFawW-A3JsvHYmYzZe9uKQA7QrA@mail.gmail.com>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <CA+GgBR8ojL-TT89y_=SvaidfFawW-A3JsvHYmYzZe9uKQA7QrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/6/21 22:09, Alexandru Ardelean wrote:
> On Fri, Jun 21, 2024 at 10:44 AM Yasin Lee <yasin.lee.x@gmail.com> wrote:


Hi Alexandru,

Thank you for your reply. I have provided some explanations regarding 
the use of HX9023S_CH_NUM in the inline comments. Please review them.

Best regards,

Yasin


>> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>>
>> The device has the following entry points:
>>
>> Usual frequency:
>> - sampling_frequency
>>
>> Instant reading of current values for different sensors:
>> - in_proximity0_raw
>> - in_proximity1_raw
>> - in_proximity2_raw
>> - in_proximity3_raw
>> - in_proximity4_raw
>> and associated events in events/
>>
> Hello :)

Hello  ^_^


>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> ---
>>   drivers/iio/proximity/Kconfig   |   14 +
>>   drivers/iio/proximity/Makefile  |    1 +
>>   drivers/iio/proximity/hx9023s.c | 1150 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1165 insertions(+)
>>
...
>> +
>> +#include <linux/array_size.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irqreturn.h>
>> +#include <linux/math.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pm.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/types.h>
>> +#include <linux/units.h>
>> +
>> +#include <asm/byteorder.h>
>> +#include <asm/unaligned.h>
>> +
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/types.h>
> A first question is: are all these headers required?
> Looks like some of them could be removed.


I checked all the header files again, following the IWYU principle 
("include what you use").

I confirm that they are all necessary. Below I listed the usage for each 
file:


#include <linux/array_size.h>  //ARRAY_SIZE
#include <linux/bitfield.h>    //FIELD_*
#include <linux/bitops.h>      //assign_bit
#include <linux/device.h>      //dev_get_drvdata
#include <linux/errno.h>       //ENOMEM @ #include <uapi/linux/errno.h>
#include <linux/i2c.h>         //i2c_client
#include <linux/interrupt.h>   //IRQF_ONESHOT
#include <linux/irqreturn.h>   //irqreturn_t
#include <linux/math64.h>      //div_u64
#include <linux/mod_devicetable.h> //MODULE_DEVICE_TABLE
#include <linux/module.h>      //MODULE_AUTHOR
#include <linux/mutex.h>       //mutex_init
#include <linux/pm.h>          //DEFINE_SIMPLE_DEV_PM_OPS
#include <linux/property.h>    //fwnode_*
#include <linux/regmap.h>      //regmap*
#include <linux/regulator/consumer.h> //devm_regulator_get_enable
#include <linux/types.h>       //u8 u32
#include <linux/units.h>       //NANO MEGA

#include <asm/byteorder.h>     //__be*  __le*
#include <asm/unaligned.h>     //get_unaligned_le16     why not 
<asm-generic/unaligned.h>

#include <linux/iio/buffer.h> //iio_push_to_buffers_with_timestamp
#include <linux/iio/events.h> //IIO_UNMOD_EVENT_CODE
#include <linux/iio/iio.h>               //iio_*
#include <linux/iio/trigger.h>           //iio_trigger*
#include <linux/iio/triggered_buffer.h> //iio_triggered_buffer*
#include <linux/iio/trigger_consumer.h> //iio_trigger_notify_done
#include <linux/iio/types.h>             //IIO_*


>> +
>> +#define HX9023S_CHIP_ID 0x1D
>> +#define HX9023S_CH_NUM 5
>> +#define HX9023S_2BYTES 2

...

>> +
>> +struct hx9023s_addr_val_pair {
>> +       u8 addr;
>> +       u8 val;
>> +};
> This looks like:
>
> struct reg_sequence {
>          unsigned int reg;
>          unsigned int def;
>          unsigned int delay_us;
> };
>
> This is defined in   include/linux/regmap.h


I will remove |hx9023s_addr_val_pair|.


...
>> +
>> +static struct hx9023s_addr_val_pair hx9023s_reg_init_list[] = {
> Globals like this should be `static const`
> Also, it would be a good idea to define this as `static const struct
> reg_sequence `
>
> Then the `regmap_multi_reg_write()` function could be used.


I will add the |const| qualifier and define the array type as 
|reg_sequence|.

I will replace the for loop with |regmap_multi_reg_write()|. This is a 
good idea.

...

>> +
>> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
>> +{
>> +       unsigned int i;
>> +       u16 reg;
>> +       u8 reg_list[HX9023S_CH_NUM * 2];
>> +       u8 ch_pos[HX9023S_CH_NUM];
>> +       u8 ch_neg[HX9023S_CH_NUM];
>> +       /* Bit positions corresponding to input pin connections */
>> +       u8 conn_cs[HX9023S_CH_NUM] = {0, 2, 4, 6, 8};
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
> See comment [1]
>
>> +               ch_pos[i] = data->ch_data[i].channel_positive == HX9023S_NOT_CONNECTED ?
>> +                       HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_positive];
>> +               ch_neg[i] = data->ch_data[i].channel_negative == HX9023S_NOT_CONNECTED ?
>> +                       HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_negative];
>> +
>> +               reg = (HX9023S_POS << ch_pos[i]) | (HX9023S_NEG << ch_neg[i]);
>> +               put_unaligned_le16(reg, &reg_list[i * 2]);
>> +       }
>> +
>> +       return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
>> +}
>> +
...
>> +
>> +static int hx9023s_sample(struct hx9023s_data *data)
>> +{
>> +       int ret, value;
>> +       unsigned int i;
>> +       u8 data_size, offset_data_size, *p, size, rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];
>> +
>> +       ret = hx9023s_data_lock(data, true);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = hx9023s_data_select(data);
>> +       if (ret)
>> +               return ret;
>  From here onwards, it looks like if there is an error, then
> `hx9023s_data_lock(data, false)` does not get called.
> Is that expected?
> Maybe some `goto err` statements would be needed?
>

This is a bug, I will fix it.


>> +
>> +       data_size = HX9023S_3BYTES;
>> +
>> +       /* ch0~ch3 */
>> +       p = rx_buf;
>> +       size = (HX9023S_CH_NUM - 1) * data_size;
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, p, size);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* ch4 */
>> +       p = rx_buf + size;
>> +       size = data_size;
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0, p, size);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
> [1]
> Maybe use some per-device (example: indio_dev->num_channels) here
> (instead of HX9023S_CH_NUM)?
> If adding support for a part with fewer channels, this would crash.
> This comment is for all places where for (i = 0; i < HX9023S_CH_NUM;
> i++)  is used
>
HX9023S_CH_NUM represents the number of configuration registers related to the channels
for this series of chips. This is the maximum value.
Regardless of the actual number of channels used, all these registers need to be configured.
Even if a certain model in this series has fewer actual channels,
Therefore, this value does not decrease due to the use of fewer channels.
Hence, I believe it should remain as it is.

>> +               value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
>> +               value = sign_extend32(value, 15);
>> +               data->ch_data[i].raw = 0;
>> +               data->ch_data[i].bl = 0;
>> +               if (data->ch_data[i].sel_raw == true)
>> +                       data->ch_data[i].raw = value;
>> +               if (data->ch_data[i].sel_bl == true)
>> +                       data->ch_data[i].bl = value;
>> +       }
>> +
>> +       /* ch0~ch3 */
>> +       p = rx_buf;
>> +       size = (HX9023S_CH_NUM - 1) * data_size;
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, p, size);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* ch4 */
>> +       p = rx_buf + size;
>> +       size = data_size;
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0, p, size);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
> See comment [1]
>
>> +               value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
>> +               value = sign_extend32(value, 15);
>> +               data->ch_data[i].lp = 0;
>> +               data->ch_data[i].diff = 0;
>> +               if (data->ch_data[i].sel_lp == true)
>> +                       data->ch_data[i].lp = value;
>> +               if (data->ch_data[i].sel_diff == true)
>> +                       data->ch_data[i].diff = value;
>> +       }
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
> See comment [1]
>
>> +               if (data->ch_data[i].sel_lp == true && data->ch_data[i].sel_bl == true)
>> +                       data->ch_data[i].diff = data->ch_data[i].lp - data->ch_data[i].bl;
>> +       }
>> +
>> +       /* offset DAC */
>> +       offset_data_size = HX9023S_2BYTES;
>> +       p = rx_buf;
>> +       size = HX9023S_CH_NUM * offset_data_size;
>> +       ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, p, size);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
> See comment [1]
>
>> +               value = get_unaligned_le16(&rx_buf[i * offset_data_size]);
>> +               value = FIELD_GET(GENMASK(11, 0), value);
>> +               data->ch_data[i].dac = value;
>> +       }
>> +
>> +       ret = hx9023s_data_lock(data, false);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +
...
>> +
>> +static int hx9023s_property_get(struct hx9023s_data *data)
>> +{
>> +       struct fwnode_handle *child;
>> +       struct device *dev = regmap_get_device(data->regmap);
>> +       int ret;
>> +       u32 i, reg, temp, array[2];
>> +
>> +       data->chan_in_use = 0;
>> +       for (i = 0; i < HX9023S_CH_NUM; i++) {
> See comment [1]
>
>> +               data->ch_data[i].channel_positive = HX9023S_NOT_CONNECTED;
>> +               data->ch_data[i].channel_negative = HX9023S_NOT_CONNECTED;
>> +       }
>> +
>> +       device_for_each_child_node(dev, child) {
>> +               ret = fwnode_property_read_u32(child, "reg", &reg);
> Maybe add a protection for when reg >= num_channels (HX9023S_CH_NUM)?


This protection is necessary. I will add it in the next version.


>> +               if (ret) {
>> +                       fwnode_handle_put(child);
>> +                       return dev_err_probe(dev, ret, "Failed to read reg\n");
>> +               }
>> +               __set_bit(reg, &data->chan_in_use);
>> +
>> +               if (fwnode_property_read_u32(child, "input-channel", &temp) == 0) {
>> +                       data->ch_data[reg].channel_positive = temp;
>> +                       data->ch_data[reg].channel_negative = HX9023S_NOT_CONNECTED;
>> +               } else if (fwnode_property_read_u32_array(child, "diff-channels",
>> +                                                       array, sizeof(array)) == 0) {
>> +                       data->ch_data[reg].channel_positive = array[0];
>> +                       data->ch_data[reg].channel_negative = array[1];
>> +               } else {
>> +                       fwnode_handle_put(child);
>> +                       return dev_err_probe(dev, ret,
>> +                               "Failed to read channel input for channel %d\n", reg);
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
...
>> +
>> +static int hx9023s_id_check(struct iio_dev *indio_dev)
>> +{
>> +       struct hx9023s_data *data = iio_priv(indio_dev);
>> +       int ret;
>> +       unsigned int id;
>> +
>> +       ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (id == HX9023S_CHIP_ID) {
>> +               indio_dev->name = "hx9023s";
> This assignment is quirky here.
> Maybe move this into the probe function?
> The rest of the function looks fine.


Okay, I will fix this as suggested.


>> +               return 0;
>> +       }
>> +
>> +       return -ENODEV;
>> +}
>> +
>> +static int hx9023s_probe(struct i2c_client *client)
>> +{
>> +       struct device *dev = &client->dev;
>> +       struct iio_dev *indio_dev;
>> +       struct hx9023s_data *data;
>> +       int ret;
>> +
>> +       indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
>> +       if (!indio_dev)
>> +               return -ENOMEM;
>> +
>> +       data = iio_priv(indio_dev);
>> +       mutex_init(&data->mutex);
>> +
>> +       data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
>> +       if (IS_ERR(data->regmap))
>> +               return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
>> +
>> +       ret = hx9023s_property_get(data);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "dts phase failed\n");
>> +
>> +       ret = devm_regulator_get_enable(dev, "vdd");
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "regulator get failed\n");
>> +
>> +       ret = hx9023s_id_check(indio_dev);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "id check failed\n");
>> +
>> +       indio_dev->channels = hx9023s_channels;
>> +       indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
>> +       indio_dev->info = &hx9023s_info;
>> +       indio_dev->modes = INDIO_DIRECT_MODE;
>> +       i2c_set_clientdata(client, indio_dev);
>> +
>> +       ret = hx9023s_reg_init(data);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "device init failed\n");
>> +
>> +       ret = hx9023s_ch_cfg(data);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "channel config failed\n");
>> +
>> +       ret = regcache_sync(data->regmap);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "regcache sync failed\n");
>> +
>> +       if (client->irq) {
>> +               ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
>> +                                               hx9023s_irq_thread_handler, IRQF_ONESHOT,
>> +                                               "hx9023s_event", indio_dev);
>> +               if (ret)
>> +                       return dev_err_probe(dev, ret, "irq request failed\n");
>> +
>> +               data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
>> +                                               iio_device_id(indio_dev));
>> +               if (!data->trig)
>> +                       return dev_err_probe(dev, -ENOMEM,
>> +                                       "iio trigger alloc failed\n");
>> +
>> +               data->trig->ops = &hx9023s_trigger_ops;
>> +               iio_trigger_set_drvdata(data->trig, indio_dev);
>> +
>> +               ret = devm_iio_trigger_register(dev, data->trig);
>> +               if (ret)
>> +                       return dev_err_probe(dev, ret,
>> +                                       "iio trigger register failed\n");
>> +       }
>> +
>> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
>> +                                       hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret,
>> +                               "iio triggered buffer setup failed\n");
>> +
>> +       ret = devm_iio_device_register(dev, indio_dev);
> A direct return would also work:
> return devm_iio_device_register(dev, indio_dev);
>
> And it would get logged if it happens.


I will fix it in V7


>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "iio device register failed\n");
>> +
>> +       return 0;
>> +}
>> +

...

>>
>> --
>> 2.25.1
>>
>>

