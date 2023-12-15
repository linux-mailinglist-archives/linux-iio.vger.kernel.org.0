Return-Path: <linux-iio+bounces-940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A0A8147A6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 13:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DE92849FB
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940A2288D5;
	Fri, 15 Dec 2023 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2D9cwf3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2B16429;
	Fri, 15 Dec 2023 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so5859781fa.3;
        Fri, 15 Dec 2023 04:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702641994; x=1703246794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBUfARMmThR9DnoHf+0gkF7h9TnHtlVW5fEjCBUsJ7s=;
        b=N2D9cwf31KJa9Ssf0ZVwhcgvjjOlwGMxwtzrEC3XwlSW7cKQsrmb1jBtrvTK/GUdee
         pHJIZcxWYzlkoegUXa7MWn0bryS8ux/sLRM1WoJsX3TVFOApDiLaTx/+vTeta1Tyfc3n
         mZWefYrFIpiIdX6F1aTL6Jj1sDy4sriJjseApQRZX66MEJkFBMSF0wb+p6mHb/xqWbfg
         YUWnfnNAPtyLMaTSRMVZ8HM1EQs3XTsPL+H5Td66IWnE6XOzz+Du7KC0O9+IGGK+WC2s
         1RLtfZThRX8tQH/8oC4FqpKvijJWb8CejkXgSOX4W/PPAYfuEHwT5qgtOJwbiG4lekXZ
         Kqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702641994; x=1703246794;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBUfARMmThR9DnoHf+0gkF7h9TnHtlVW5fEjCBUsJ7s=;
        b=Ucpffa7Jb0Ri9/bHv+MqVJf+HVwBtG4YggsbmdXAnjRY6sQnMXRGkxvdynmL1qHm8C
         WJTsJFB9AezyhPb1RE9wlhLB7cSi5vRFR0E2uf/USPt87p+HuewoyCWIVMkw+gJkJa0c
         zygaaE0202fWmsib3S/8pydlh6LAyeujeFtxZ6kblZcKeD6sZbjKcyrbu9ue/Qu0EQ6L
         HBWdI+ipKbSQ7m5nSGe7qNVK1N6Lv75D4Uc7ySNVqSmEopxg322pKDGc06qMFmfhkr7R
         6bmhYBQkWMH9gek+VywNQGB7UJoWkkh7flZdF2AKR3JZX57nxEK3pBY3E4jfHfU8seFh
         1EVQ==
X-Gm-Message-State: AOJu0YwlH0+zHuupfp6DAMbpJj3LciMm1h5mliCvBImxunqxz58V1zwQ
	mic5YYRANcMibaJDKuVzwakX9y6KnSc=
X-Google-Smtp-Source: AGHT+IGVDEwMnRPwxUAV74zc3GX2mgij+XgY26JBQhWeDhSha4fJ0tyoruQJE5EQrXnasMQ8+By2TQ==
X-Received: by 2002:a2e:a103:0:b0:2cb:54a6:5c89 with SMTP id s3-20020a2ea103000000b002cb54a65c89mr4737720ljl.107.1702641994238;
        Fri, 15 Dec 2023 04:06:34 -0800 (PST)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e87d2000000b002ca013cb05csm2432031ljj.79.2023.12.15.04.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 04:06:33 -0800 (PST)
Message-ID: <dff1e2f9-c2a1-4262-b80b-ce0c144fdaf5@gmail.com>
Date: Fri, 15 Dec 2023 14:06:32 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: isl76682: Add ISL76682 driver
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231121031043.327614-1-marex@denx.de>
 <20231121031043.327614-2-marex@denx.de>
 <8b865546-0e51-45ff-ab76-8189afaa9ad5@gmail.com>
 <cd21c72f-d9ff-471d-a08d-9b67bf180950@denx.de>
 <4a39aff2-bb1a-447c-8c33-8bfad06777e3@gmail.com>
Content-Language: en-US, en-GB
In-Reply-To: <4a39aff2-bb1a-447c-8c33-8bfad06777e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/23/23 09:24, Matti Vaittinen wrote:
> On 11/23/23 02:26, Marek Vasut wrote:
>> On 11/22/23 13:17, Matti Vaittinen wrote:
>>> On 11/21/23 05:10, Marek Vasut wrote:

..snip

>>> I like this table-based look-up for write (and read) of scales. 
>>> Looking at this I see an analogy to some of the regulator stuff, like 
>>> for example the ramp-up values. What I do very much like in the 
>>> regulator subsystem is the drivers/regulator/helpers.c
>>>
>>> I wonder if similar approach would be usable in IIO as well? I mean, 
>>> providing readily written iio_regmap_read/write_raw_<functionality>() 
>>> and iio_available_*() helpers for the simple devices where we just 
>>> have value-register mapping? I mean, driver would just populate 
>>> something like:
>>>
>>> struct iio_scale_desc {
>>>      int *scale_val_table;
>>>      int *scale_val2_table;
>>>      int num_scales;
>>
>> You'd also need type here (fractional, int+micro, ...), right ?
> 
> Well, my thinking was to go with baby-steps. Eg, start by supporting 
> just int+micro - but yes. As I wrote below, this can be expanded by 
> allowing specifying the type.
> 
>>>      int scale_reg_addr;
>>>      int scale_reg_mask;
>>> };
>>>
>>> and call helper like
>>> int iio_regmap_read_raw_scale(struct iio_dev *idev,
>>>                    struct iio_scale_desc *sd, int *val,
>>>                    int *val2)"
>>> provided by IIO framework.
>>>
>>> Similar helper for writing new scales and getting available scales.
>>>
>>> Later this could be expanded by allowing specifying the type of 
>>> provided values (in the example case, IIO_VAL_INT_PLUS_x - but maybe 
>>> this would be extensible (and worth) to support also the other options?)
>>>

... snip

>>
>> The only thing I would wonder about is, should such a thing go into 
>> regmap so it can be reused cross-subsystem instead of making this iio 
>> specific ?
> 
> I definitely think a relation "register value" <=> "item from a table" 
> is very much used also outside the IIO. So yes, a generic regmap helper 
> for doing write as a "look value from table and write corresponding 
> value to a register" and "read value from register and return me a 
> corresponding item from a table" would be very usable.
> 
> There is a tradeoff when doing a generic one instead of making it 
> targeted for IIO use. Supporting different types of data is likely to 
> make the code a bit hairy. Also, the IIO way of having these IIO_VAL_* 
> flags does probably require IIO - specific wrappers in any case.

I had some spare time so drafted following:

+struct reg_val_table {
+       int *reg_vals;
+       int *vals;
+       int num_vals;
+};

...

+/**
+ * regtable_find_val - find a value matching register setting
+ *
+ * Search given table for value mathcing a register setting.
+ *
+ * @table:     Table from which the register setting - value pairs are
+ *             searched.
+ * @reg:       Register value for which the matching physical value is
+ *             searched.
+ * @val:       Pointer to location where the found value will be stored.
+ *
+ * returns:    0 on success, negative errno if table is invalid or match is
+ *             not found.
+ */
+int regtable_find_val(const struct reg_val_table *table, int reg, int *val)


+/**
+ * regtable_find_reg - find a register setting matching given value.
+ *
+ * Search given table for a register setting matching a value.
+ *
+ * @table:     Table from which the register setting - value pairs are
+ *             searched.
+ * @val:       Value for which the matching register setting is searched.
+ * @reg:       Pointer to location where the found register value will be
+ *             stored.
+ *
+ * returns:    0 on success, negative errno if table is invalid or match is
+ *             not found.
+ */
+int regtable_find_reg(const struct reg_val_table *table, int val, int *reg)


+/**
+ * regtable_find_greater_than_val - find the closest greater val and reg
+ *
+ * Search given table for the smallest value which is still greater than
+ * the given value. Both the found value and corresponding register
+ * setting are returned unless given pointers are NULL.
+ *
+ * @table:     Table from which the register setting - value pairs are
+ *             searched.
+ * @val_cmp:   Value to which the values stored in table are compared to.
+ * @reg:       NULL or pointer to location where the matching register
+ *             setting value will be stored.
+ * @val:       NULL or pointer to location where the found value will be
+ *             stored.
+ *
+ * returns:    0 on success, negative errno if table is invalid or match is
+ *             not found.
+ */
+int regtable_find_greater_than_val(const struct reg_val_table *table, 
int val_cmp,
+                                  int *reg, int *val)


+/**
+ * regtable_find_smaller_than_val - find the closest smaller val and reg
+ *
+ * Search given table for the greatest value which is still smaller than
+ * the given value. Both the found value and corresponding register
+ * setting are returned unless given pointers are NULL.
+ *
+ * @table:     Table from which the register setting - value pairs are
+ *             searched.
+ * @val_cmp:   Value to which the values stored in table are compared to.
+ * @reg:       NULL or pointer to location where the matching register
+ *             setting value will be stored.
+ * @val:       NULL or pointer to location where the found value will be
+ *             stored.
+ *
+ * returns:    0 on success, negative errno if table is invalid or match is
+ *             not found.
+ */
+int regtable_find_smaller_than_val(const struct reg_val_table *table,
+                                  int val_cmp, int *reg, int *val)


and

+struct regmap_regval_table {
+       const struct reg_val_table table;
+       int reg;
+       int mask;
+};

+/**
+ * regmap_table_value_set - update register to match 
human-understandable value
+ * @map:       Register map
+ * @table:     Table describing register-value, human-readable value 
relation
+ * value:      Human understandable value to configure in hardware.
+ *
+ * Return:     0 on success, negative errno on error.
+ */
+int regmap_table_value_set(struct regmap *map,
+                          const struct regmap_regval_table *table, int 
value)


+/**
+ * regmap_table_value_get - return human-understandable configuration
+ *
+ * Reads hardware or regmap cache for current hardware configuration and
+ * converts the read register value to human understandable entity.
+ * @map:       Register map
+ * @table:     Table describing register-value, human-readable value 
relation
+ * value:      Human understandable value to configure in hardware.
+ *
+ * Return:     0 on success, negative errno on error.
+ */
+int regmap_table_value_get(struct regmap *map,
+                          const struct regmap_regval_table *table, int 
*value)


(for anyone interested, whole thing + tests can be found from:
https://github.com/M-Vaittinen/linux/commits/regtable/
Just last 3 commits.)

I am however having difficulties in seeing how this could be utilized by 
IIO, which tends to rely on values being represented by two integers 
(val and val2).

Any suggestions regarding this idea? I'm wondering if I should just 
scrap this and try seeing if I can make an IIO-specific helper(s) - or 
if someone sees this would bring additional value worth an proper RFC? I 
don't want to sen an RFC for people to properly review if this idea is 
just plain stupid :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


