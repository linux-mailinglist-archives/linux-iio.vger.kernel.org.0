Return-Path: <linux-iio+bounces-24460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E78BA4732
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 17:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EF67B24BD
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825AB218827;
	Fri, 26 Sep 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hakOpank"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6920CCCA
	for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901143; cv=none; b=YaQshtTl+hvbRUPBM+g+gKFKSyF1hWOTPMZ6dzAtGp5yWkp1KWN0HYhlYiOOU1XLUAvICQevSHzixeZdsza2uO1IraBb/r/nfoXZ3La4Hk3PLIgEYLk2iOUJxryqh+4OSydD1VKhFm3XWURL2EgLDiKTeYyPgSmmJmI9DkKBLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901143; c=relaxed/simple;
	bh=1K4sUGLBHZ9fUpOAIcQYsW8EpilQp6Ba5qGwrWESZls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LENZX7A45HGnbgnWQPuef0Ohwlp5pWPeUAlZPDK3gOGb014rrg4EgKq7b9AB5cTTwS7ngP10RnUcIKB9NUXqAvSFnNcG7/o5cf81Z5Z9K7yDKY++gW3NksGG22VSJMMzkUdX0QXCCrF99i0h0eSLtP1Hrh+JVfwgiiyJJBpt2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hakOpank; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46b303f755aso21036915e9.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758901139; x=1759505939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kgAcNQqeMGknJHmQ8ARkX/S7uQVoabri2v53BdYsfU=;
        b=hakOpank/89agKnos/6ubztSlGiKtW8OKD52vcOFDWZAYVEF03rW+npPH+Xa4EneDW
         5TMSp3Oh3hZDymRng4CZwmsH9vzavBnC6zsccxrnQ9Tat94vmsZVOANVkoUhmm3hMXP+
         rI7N4h/nWQRRb10uOqiZ5SQuIgRSH27Si7B88pCcLpA8QXucO9rK3gxHUlh4blOV34Z8
         KHNuSuIQii+egTIy+rPFXWbM6aqwwX8G3Tz0HaGZbiY9CEjb85WVaKXn3WMOEyGtT3GX
         uJ490edJp2Qjb+IV4JI/3ZVtVHlJA/w9FJhmX0ieelpLuHXKfEUavyqXMx1RS6CO5yef
         /QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901139; x=1759505939;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kgAcNQqeMGknJHmQ8ARkX/S7uQVoabri2v53BdYsfU=;
        b=MMuBMbE1ZMaQIL83MDDqoAep5H3BDA3Oy8dtEOOSC7KeOLRAZU6iSxNuBkV/jHcCvc
         5aX2hbx3axU3rq5XjRLLkErSdPMtUhi8zaLM6vff9Dkb5cNtoWN5FNTPMiyqBCnR+EtG
         j3GpqEayQzR+FEMQLt1W4PxkUmY2EVEqJUc2sUTJ3zv67J5himHk3US+5OrqZm9heaRQ
         B1lWckfZDEZX1MEyUAiTyt4EoMFxnkSHmPoEVnBRlKMeC3n1jwN5x73LAp51MAGxobpN
         KlmuC9QIUYPqMxJoG9yUlUd//xlkLDTz7e6d2gUI/EUjFoVVER6rkxtShqP3iYwUgwV/
         03eg==
X-Forwarded-Encrypted: i=1; AJvYcCUf8hIz+K5OQveSQ3sNBOG6IbGoU6q7VtLuJN2zFUkdegsyqdwFR9jYzmTnhHVVj8jhoHcF6gj3q7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrnuouLhv//pEcBAblbFs4dmL568n/htaHItoxOK/xEdickz5
	AhVgyYXnGH5ZNeFrERlhlBxFD4UOq78vlRuiPRrh9HpQfPYbqbhg2VTRYqVxZsLVZOc=
X-Gm-Gg: ASbGncsNgKO4/ss4Fp+rKqI60pEUzhn4ZrenLt1CA9O2qQ+jgvOUtu91QFCoqOJfeJ1
	BVYkAE1FglpRveERuOk3R8Khc4oalEaoIPpQ6Enta8UvNPxx6uuPWKqNWBIrSSBJIAhVkETIvt2
	/+eYhGmmnRfxoNQTBIpKoXOnroZErllv9YzTGj/TNivYJytDPgJm5nj/7Uo8qY3vmpveZL20okf
	epbZEx0e4t6PiDOLC+BGWrWNhOKjtV6KeD8b9HaxbufQEOiWAvbiJf8HFzaQwTAmuIicCIwwPSH
	iQv30S26HA81jGmsf4CIVqVV6xw3laPj6yxkwbPfS1dfd9Vf/yxI8Te6oHuw/k7FoDFYfafp9BZ
	VLZtnKtlW3hJANuaj4fwqfgKxBvBNbV0zP3qIeEcRtB/j6OHhcw==
X-Google-Smtp-Source: AGHT+IG4FIOGcvrxDMC6xc6YryyjWgNtEn/gDy55HG40g/qAQlKrQwZkQXuag7kr8tkIOAvWnC4WqA==
X-Received: by 2002:a05:600c:310c:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46e35a037c8mr56312325e9.27.1758901139257;
        Fri, 26 Sep 2025 08:38:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc5602df0sm7507709f8f.36.2025.09.26.08.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:38:58 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:38:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ariana Lazar <ariana.lazar@microchip.com>
Subject: Re: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <202509262228.MYSY2WkV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>

Hi Ariana,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Ariana-Lazar/dt-bindings-iio-dac-adding-support-for-Microchip-MCP47FEB02/20250922-193559
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20250922-mcp47feb02-v1-2-06cb4acaa347%40microchip.com
patch subject: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
config: x86_64-randconfig-r073-20250926 (https://download.01.org/0day-ci/archive/20250926/202509262228.MYSY2WkV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509262228.MYSY2WkV-lkp@intel.com/

smatch warnings:
drivers/iio/dac/mcp47feb02.c:1258 mcp47feb02_probe() error: uninitialized symbol 'vref_mv'.
drivers/iio/dac/mcp47feb02.c:1258 mcp47feb02_probe() error: uninitialized symbol 'vref1_mv'.

vim +/vref_mv +1258 drivers/iio/dac/mcp47feb02.c

2e305393740054 Ariana Lazar 2025-09-22  1108  static int mcp47feb02_probe(struct i2c_client *client)
2e305393740054 Ariana Lazar 2025-09-22  1109  {
2e305393740054 Ariana Lazar 2025-09-22  1110  	int err, ret, vdd_mv, vref_mv, vref1_mv, i, tmp_vref, vref_ch, gain_ch;
2e305393740054 Ariana Lazar 2025-09-22  1111  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
2e305393740054 Ariana Lazar 2025-09-22  1112  	const struct mcp47feb02_features *info;
2e305393740054 Ariana Lazar 2025-09-22  1113  	enum vref_mode ref_mode, ref_mode1;
2e305393740054 Ariana Lazar 2025-09-22  1114  	struct device *dev = &client->dev;
2e305393740054 Ariana Lazar 2025-09-22  1115  	struct mcp47feb02_data *data;
2e305393740054 Ariana Lazar 2025-09-22  1116  	struct iio_dev *indio_dev;
2e305393740054 Ariana Lazar 2025-09-22  1117  
2e305393740054 Ariana Lazar 2025-09-22  1118  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
2e305393740054 Ariana Lazar 2025-09-22  1119  	if (!indio_dev)
2e305393740054 Ariana Lazar 2025-09-22  1120  		return -ENOMEM;
2e305393740054 Ariana Lazar 2025-09-22  1121  
2e305393740054 Ariana Lazar 2025-09-22  1122  	data = iio_priv(indio_dev);
2e305393740054 Ariana Lazar 2025-09-22  1123  	i2c_set_clientdata(client, indio_dev);
2e305393740054 Ariana Lazar 2025-09-22  1124  	data->client = client;
2e305393740054 Ariana Lazar 2025-09-22  1125  	info = i2c_get_match_data(client);
2e305393740054 Ariana Lazar 2025-09-22  1126  
2e305393740054 Ariana Lazar 2025-09-22  1127  	if (info->have_eeprom) {
2e305393740054 Ariana Lazar 2025-09-22  1128  		data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
2e305393740054 Ariana Lazar 2025-09-22  1129  		data->have_eeprom = true;
2e305393740054 Ariana Lazar 2025-09-22  1130  	} else {
2e305393740054 Ariana Lazar 2025-09-22  1131  		data->regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
2e305393740054 Ariana Lazar 2025-09-22  1132  		data->have_eeprom = false;
2e305393740054 Ariana Lazar 2025-09-22  1133  	}
2e305393740054 Ariana Lazar 2025-09-22  1134  
2e305393740054 Ariana Lazar 2025-09-22  1135  	if (IS_ERR(data->regmap))
2e305393740054 Ariana Lazar 2025-09-22  1136  		dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c regmap\n");
2e305393740054 Ariana Lazar 2025-09-22  1137  
2e305393740054 Ariana Lazar 2025-09-22  1138  	err = mcp47feb02_parse_fw(indio_dev, info);
2e305393740054 Ariana Lazar 2025-09-22  1139  	if (err)
2e305393740054 Ariana Lazar 2025-09-22  1140  		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
2e305393740054 Ariana Lazar 2025-09-22  1141  
2e305393740054 Ariana Lazar 2025-09-22  1142  	if (!info->have_ext_vref2 && data->use_vref1)
2e305393740054 Ariana Lazar 2025-09-22  1143  		return dev_err_probe(dev, -EINVAL,
2e305393740054 Ariana Lazar 2025-09-22  1144  				     "Second External reference is unavailable on %s\n",
2e305393740054 Ariana Lazar 2025-09-22  1145  				     info->name);
2e305393740054 Ariana Lazar 2025-09-22  1146  
2e305393740054 Ariana Lazar 2025-09-22  1147  	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_VREF_REG_ADDR, READ_CMD), &vref_ch);
2e305393740054 Ariana Lazar 2025-09-22  1148  	if (ret)
2e305393740054 Ariana Lazar 2025-09-22  1149  		return ret;
2e305393740054 Ariana Lazar 2025-09-22  1150  
2e305393740054 Ariana Lazar 2025-09-22  1151  	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_GAIN_STATUS_REG_ADDR, READ_CMD),
2e305393740054 Ariana Lazar 2025-09-22  1152  			  &gain_ch);
2e305393740054 Ariana Lazar 2025-09-22  1153  	if (ret)
2e305393740054 Ariana Lazar 2025-09-22  1154  		return ret;
2e305393740054 Ariana Lazar 2025-09-22  1155  
2e305393740054 Ariana Lazar 2025-09-22  1156  	gain_ch = gain_ch >> 8;
2e305393740054 Ariana Lazar 2025-09-22  1157  
2e305393740054 Ariana Lazar 2025-09-22  1158  	/*
2e305393740054 Ariana Lazar 2025-09-22  1159  	 * Values stored in the nonvolatile memory will be transferred to the volatile registers
2e305393740054 Ariana Lazar 2025-09-22  1160  	 * at startup. For safety reasons, the user receives a warning if startup values
2e305393740054 Ariana Lazar 2025-09-22  1161  	 * do not match the ones from current devicetree configuration.
2e305393740054 Ariana Lazar 2025-09-22  1162  	 * Nonvolatile memory can be written at any time
2e305393740054 Ariana Lazar 2025-09-22  1163  	 */
2e305393740054 Ariana Lazar 2025-09-22  1164  	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
2e305393740054 Ariana Lazar 2025-09-22  1165  		/* VDD can be set as Vref only with Gain x1 */
2e305393740054 Ariana Lazar 2025-09-22  1166  		if ((vref_ch & 0x03) == MCP47FEB02_VREF_VDD &&
2e305393740054 Ariana Lazar 2025-09-22  1167  		    (gain_ch & 0x01) == MCP47FEB02_GAIN_X2) {
2e305393740054 Ariana Lazar 2025-09-22  1168  			dev_info(dev, "vdd can be used only with gain x1\n");
2e305393740054 Ariana Lazar 2025-09-22  1169  			ret = mcp47feb02_write_to_register(data->regmap,
2e305393740054 Ariana Lazar 2025-09-22  1170  							   MCP47FEB02_GAIN_STATUS_REG_ADDR,
2e305393740054 Ariana Lazar 2025-09-22  1171  							   i, MCP47FEB02_GAIN_X1);
2e305393740054 Ariana Lazar 2025-09-22  1172  			if (ret)
2e305393740054 Ariana Lazar 2025-09-22  1173  				return ret;
2e305393740054 Ariana Lazar 2025-09-22  1174  
2e305393740054 Ariana Lazar 2025-09-22  1175  			data->chdata[i].use_2x_gain = MCP47FEB02_GAIN_X1;
2e305393740054 Ariana Lazar 2025-09-22  1176  		}
2e305393740054 Ariana Lazar 2025-09-22  1177  
2e305393740054 Ariana Lazar 2025-09-22  1178  		if (data->phys_channels >= 4 && (i % 2)) {
2e305393740054 Ariana Lazar 2025-09-22  1179  			if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_BUFFERED &&
2e305393740054 Ariana Lazar 2025-09-22  1180  			    data->use_vref1 && !data->vref1_buffered)
2e305393740054 Ariana Lazar 2025-09-22  1181  				dev_info(dev, "vref1 is unbuffered\n");
2e305393740054 Ariana Lazar 2025-09-22  1182  			else if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED &&
2e305393740054 Ariana Lazar 2025-09-22  1183  				 data->use_vref1 && data->vref1_buffered)
2e305393740054 Ariana Lazar 2025-09-22  1184  				dev_info(dev, "vref1 is buffered\n");
2e305393740054 Ariana Lazar 2025-09-22  1185  		} else {
2e305393740054 Ariana Lazar 2025-09-22  1186  			if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_BUFFERED &&
2e305393740054 Ariana Lazar 2025-09-22  1187  			    data->use_vref && !data->vref_buffered)
2e305393740054 Ariana Lazar 2025-09-22  1188  				dev_info(dev, "vref is unbuffered\n");
2e305393740054 Ariana Lazar 2025-09-22  1189  			else if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED &&
2e305393740054 Ariana Lazar 2025-09-22  1190  				 data->use_vref && data->vref_buffered)
2e305393740054 Ariana Lazar 2025-09-22  1191  				dev_info(dev, "vref is buffered\n");
2e305393740054 Ariana Lazar 2025-09-22  1192  		}
2e305393740054 Ariana Lazar 2025-09-22  1193  
2e305393740054 Ariana Lazar 2025-09-22  1194  		vref_ch = vref_ch >> 2;
2e305393740054 Ariana Lazar 2025-09-22  1195  		gain_ch = gain_ch >> 1;
2e305393740054 Ariana Lazar 2025-09-22  1196  	}
2e305393740054 Ariana Lazar 2025-09-22  1197  
2e305393740054 Ariana Lazar 2025-09-22  1198  	if (data->use_vref)
2e305393740054 Ariana Lazar 2025-09-22  1199  		ref_mode = data->vref_buffered ?
2e305393740054 Ariana Lazar 2025-09-22  1200  			MCP47FEB02_EXTERNAL_VREF_BUFFERED : MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
2e305393740054 Ariana Lazar 2025-09-22  1201  	else
2e305393740054 Ariana Lazar 2025-09-22  1202  		ref_mode = MCP47FEB02_INTERNAL_BAND_GAP;
2e305393740054 Ariana Lazar 2025-09-22  1203  
2e305393740054 Ariana Lazar 2025-09-22  1204  	if (data->use_vref1)
2e305393740054 Ariana Lazar 2025-09-22  1205  		ref_mode1 = data->vref1_buffered ?
2e305393740054 Ariana Lazar 2025-09-22  1206  			MCP47FEB02_EXTERNAL_VREF_BUFFERED : MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
2e305393740054 Ariana Lazar 2025-09-22  1207  
2e305393740054 Ariana Lazar 2025-09-22  1208  	else
2e305393740054 Ariana Lazar 2025-09-22  1209  		ref_mode1 =  MCP47FEB02_INTERNAL_BAND_GAP;
2e305393740054 Ariana Lazar 2025-09-22  1210  
2e305393740054 Ariana Lazar 2025-09-22  1211  	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
2e305393740054 Ariana Lazar 2025-09-22  1212  		if (data->phys_channels >= 4 && (i % 2))
2e305393740054 Ariana Lazar 2025-09-22  1213  			tmp_vref = ref_mode1;
2e305393740054 Ariana Lazar 2025-09-22  1214  		else
2e305393740054 Ariana Lazar 2025-09-22  1215  			tmp_vref = ref_mode;
2e305393740054 Ariana Lazar 2025-09-22  1216  
2e305393740054 Ariana Lazar 2025-09-22  1217  		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_VREF_REG_ADDR,
2e305393740054 Ariana Lazar 2025-09-22  1218  						   i, tmp_vref);
2e305393740054 Ariana Lazar 2025-09-22  1219  		if (ret)
2e305393740054 Ariana Lazar 2025-09-22  1220  			return ret;
2e305393740054 Ariana Lazar 2025-09-22  1221  
2e305393740054 Ariana Lazar 2025-09-22  1222  		data->chdata[i].ref_mode = tmp_vref;
2e305393740054 Ariana Lazar 2025-09-22  1223  	}
2e305393740054 Ariana Lazar 2025-09-22  1224  
2e305393740054 Ariana Lazar 2025-09-22  1225  	indio_dev->name = id->name;
2e305393740054 Ariana Lazar 2025-09-22  1226  	if (info->have_eeprom)
2e305393740054 Ariana Lazar 2025-09-22  1227  		indio_dev->info = &mcp47feb02_info;
2e305393740054 Ariana Lazar 2025-09-22  1228  	else
2e305393740054 Ariana Lazar 2025-09-22  1229  		indio_dev->info = &mcp47fvb02_info;
2e305393740054 Ariana Lazar 2025-09-22  1230  
2e305393740054 Ariana Lazar 2025-09-22  1231  	ret = devm_mutex_init(dev, &data->lock);
2e305393740054 Ariana Lazar 2025-09-22  1232  	if (ret < 0)
2e305393740054 Ariana Lazar 2025-09-22  1233  		return ret;
2e305393740054 Ariana Lazar 2025-09-22  1234  
2e305393740054 Ariana Lazar 2025-09-22  1235  	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
2e305393740054 Ariana Lazar 2025-09-22  1236  	if (ret < 0)
2e305393740054 Ariana Lazar 2025-09-22  1237  		return ret;
2e305393740054 Ariana Lazar 2025-09-22  1238  
2e305393740054 Ariana Lazar 2025-09-22  1239  	vdd_mv = ret / 1000;
2e305393740054 Ariana Lazar 2025-09-22  1240  
2e305393740054 Ariana Lazar 2025-09-22  1241  	if (data->use_vref) {
2e305393740054 Ariana Lazar 2025-09-22  1242  		ret = devm_regulator_get_enable_read_voltage(dev, "vref");
2e305393740054 Ariana Lazar 2025-09-22  1243  		if (ret < 0)
2e305393740054 Ariana Lazar 2025-09-22  1244  			return ret;
2e305393740054 Ariana Lazar 2025-09-22  1245  
2e305393740054 Ariana Lazar 2025-09-22  1246  		vref_mv = ret / 1000;
2e305393740054 Ariana Lazar 2025-09-22  1247  	}

uninitialized on else path.

2e305393740054 Ariana Lazar 2025-09-22  1248  
2e305393740054 Ariana Lazar 2025-09-22  1249  	if (data->use_vref1) {
2e305393740054 Ariana Lazar 2025-09-22  1250  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
2e305393740054 Ariana Lazar 2025-09-22  1251  		if (ret < 0)
2e305393740054 Ariana Lazar 2025-09-22  1252  			return ret;
2e305393740054 Ariana Lazar 2025-09-22  1253  
2e305393740054 Ariana Lazar 2025-09-22  1254  		vref1_mv = ret / 1000;
2e305393740054 Ariana Lazar 2025-09-22  1255  	}

vref1_mv not initialized on else path.

2e305393740054 Ariana Lazar 2025-09-22  1256  
2e305393740054 Ariana Lazar 2025-09-22  1257  	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
2e305393740054 Ariana Lazar 2025-09-22 @1258  		ret = mcp47feb02_init_scales_avail(info, data, vdd_mv, vref_mv, vref1_mv);

It doesn't matter that mcp47feb02_init_scales_avail() checks data->use_vref
and data->use_vref1.  It's considered a bug anyway because the function is
not marked as __always_inline.  UBSan will complain at runtime as well.

2e305393740054 Ariana Lazar 2025-09-22  1259  		if (ret)
2e305393740054 Ariana Lazar 2025-09-22  1260  			dev_err_probe(dev, ret, "failed to init scales for ch i %d\n", i);
2e305393740054 Ariana Lazar 2025-09-22  1261  	}
2e305393740054 Ariana Lazar 2025-09-22  1262  
2e305393740054 Ariana Lazar 2025-09-22  1263  	err = iio_device_register(indio_dev);
2e305393740054 Ariana Lazar 2025-09-22  1264  
2e305393740054 Ariana Lazar 2025-09-22  1265  	return err;
2e305393740054 Ariana Lazar 2025-09-22  1266  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


