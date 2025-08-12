Return-Path: <linux-iio+bounces-22621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E9B22BC6
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF198503916
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91BB2F533B;
	Tue, 12 Aug 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FwCz1DDX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5452EBDC5
	for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012854; cv=none; b=I47RROAASQWp+T7733hew/Q3HIpfqnVsfpJI1ZmQNXzsxQOuhowSFVgbNY1ML2P4hYcnLMHXDcK5Q4ngB5wELhePynGDRXJ4cg07U5fyYuD5DMpCU+ptlQPeKzeNMd+50UsgTk7e3j7qSIfJvaE515g1+UZpRhSx59K0snGfOCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012854; c=relaxed/simple;
	bh=xaeWnJ5wkRdOsQs1+RdAsfMNuHQdh6ejaqjcgSCAdLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=slnCvxWywsCoJLREtYju4rHr/S7U833iUZ+1g9BGoOQzNeqTYtObzUk2oKC08yO8qDxolLnFInXSNv+C7eCZaJcttJqHp1i1Eaq0apAqjUH+zCSv+B0V6LGsRqczaFu2CU5yg4liJzWrpZ52yhQCKBFbiYsbSlPb9bIl6obeNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FwCz1DDX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-306db05b292so1884194fac.1
        for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755012850; x=1755617650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+EQoHQpdLoccE7byal3Z0g90/NiviiY9nwSpgAP6KmU=;
        b=FwCz1DDX2CwEDF/a2oUkXFVau3oSewPB7UAj4AU3a59jUlsed12cbjYqPU8hLoNn/h
         1cQfLTGOrHQvYVVZ9mTjkkvLwNf2HmZRa4/d/Cgg0lPYmif7TyyVgyseIRBD3ya8kMFV
         V1u/7hV+UehtrsP5fmhehMkhh/7U6uD//gjfazSPGq1h8IaYAaijRTtDHZGgmIa7Q7kt
         pJMogmvRcRx8Hgby4i1azwcRCdaoK/ZeRQGZpW4C85B6RjBkZsIjDDHCJK8gOvMPr25q
         kdqFLc+9aI7VR3jRmPGaQW50huUOu5A6ggQPPQAIjDrr10FIrZtwliUHVHah38VTN72m
         oZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755012850; x=1755617650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EQoHQpdLoccE7byal3Z0g90/NiviiY9nwSpgAP6KmU=;
        b=ERhrWel5IImPN/T+i7asIOlTm/vHgcAi3AcF2RIVJCkEcwNCZtrcoLemGx4+t58xhm
         DW+M00yvvEtrSaJ66ktZiXXq6feQTsFLRCJc/knj+imAoUqDxUufMKMPgMyoWsKYim4h
         SGIuxKo+Q30hnxaAefhGcDjlJuGJ0O0dRko8Ckj9B2d7ekX1vFtAUui4smXaCBDqe1Z+
         OShNF9hI/xbQsOwva+K+Zx/l/ASchCyJ+FzlKGVUtojZ//+oub3Xg0o6eQZ+nYjVSklj
         rPxYqWSXcrYxUvh2w2Q6GDGZ7Meyz82GleEbnKndIEmX3zdL054x9yXl0EHjPg7aw/Pd
         e6TQ==
X-Gm-Message-State: AOJu0Yz0Sy+RGm0ngZRA2XoCVk3UmP57mIVhGvRF3O/UlDZMNIhaX1hz
	SFDKnBX2o7ROarRki1nfxA2y6EPRYkO5YEqFbXprrWidIFlgyMHcAUXELHWkIVqFWS18yQYqnCS
	rYcBE
X-Gm-Gg: ASbGncv6xe9QwaJmpEdv8BHajpcIkmMbtfO684szBShgJBVk9warT8JQlIyC7mrKG6q
	fLaIMgFHc66lFFNm+9mrH6xjDsvhbaPGrRhUJ08LSZq4wsOEM+EzBVh1sI9egvfDeuqYj9GaMZe
	wrkbtJDhG7FNh4OGev+kgkID7xqPP8n+YqJZ/hvo9Tm4x3/7o6EaizSuiZjud65olQFpdmShok9
	PY/A9xy7P6IT7kePMCfl0ViQwqVG2NOz37O/fdonnVijfWyss1MrRhHUKVaQnMG07Bu7HWz79gR
	hdfM8C1P6X6DoJbswszF9belYCW3/KuY9W/8H8d9ZNoVZnwbL5dH6Dn19cH54mNaoPv4IC2NxFx
	cL+niQRy7lWCw/vNFivjDzP/sCZsIkEmDo/vfolE4LgZZFkc6VjQkA9TA5pn5KXpjioh8MrcdI3
	Lufken9Q7OVA==
X-Google-Smtp-Source: AGHT+IH3+67Bpmwt8b5E1oD0rMhZf8pp6j8Ed5gmKyMStmI9U7W+QB1lbPEKEAmNqKjd1DII8HhXgg==
X-Received: by 2002:a05:6870:6c11:b0:306:e92f:8a68 with SMTP id 586e51a60fabf-30c94e7ffd0mr2320201fac.2.1755012848420;
        Tue, 12 Aug 2025 08:34:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1fd1:71c7:ca6b:f533? ([2600:8803:e7e4:1d00:1fd1:71c7:ca6b:f533])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30bedd2c7dfsm4712007fac.23.2025.08.12.08.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:34:07 -0700 (PDT)
Message-ID: <2214d559-5a5f-40e5-aa46-298ac2eaa9c2@baylibre.com>
Date: Tue, 12 Aug 2025 10:34:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mcp9600: Add support for mcp9601 and sensor config
To: linux-iio@vger.kernel.org, Andrew Hepp <andrew.hepp@ahepp.dev>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <6esdq4e4r7vmxwlyfs4a3sgdomazxospr3go2oaqkwhpgw6mkh@hdca2d3f6zwp>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6esdq4e4r7vmxwlyfs4a3sgdomazxospr3go2oaqkwhpgw6mkh@hdca2d3f6zwp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/12/25 8:08 AM, Ben Collins wrote:
> The mcp9600 dt binding doc claims to support thermocouple-type but
> I don't see where this is implemented.
> 
> - Add support to detect mcp9601 device type
> - Add support to use thermocouple-type dt prop
> - Add thrermocouple iio info to get/set this from sysfs
> - Add filter-level dt prop to set the filtering level of the chip
> - Update dt binding docs

This is too much for one patch. Split the thermocouple type and
filter level into separate patches.

> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> Cc: Andrew Hepp <andrew.hepp@ahepp.dev>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> ---

The dependency on your other patch should be mentioned here.
Or just include the other patch in the series too.

>  .../iio/temperature/microchip,mcp9600.yaml    |   9 +
>  drivers/iio/temperature/mcp9600.c             | 185 ++++++++++++++++--
>  2 files changed, 181 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> index d2cafa38a5442..0ee0259471c6a 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -42,6 +42,14 @@ properties:
>        Use defines in dt-bindings/iio/temperature/thermocouple.h.
>        Supported types are B, E, J, K, N, R, S, T.
>  
> +  filter-level:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Level of chip filtering to use. 0 means filtering is disabled.
> +      See reference manual 5.2.2 - THERMOCOUPLE SENSOR CONFIGURATION
> +      REGISTER, FIGURE 5-6 for Filter Step Response graph. Supported
> +      values are in the range of 0-7.
> +

Devicetree binding changes need to be in a separate patch and CC the
relevant maintainers.

However, this looks like something that doesn't belong in a devicetree.
Unless you can justify why the filtering level depends on how the
system is wired up, this is more likely something that should be
done at runtime.

I only had a very quick look a the datasheet, but I think using
IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY to control the filter
range would make sense.

>    vdd-supply: true
>  
>  required:
> @@ -65,6 +73,7 @@ examples:
>              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>              interrupt-names = "open-circuit";
>              thermocouple-type = <THERMOCOUPLE_TYPE_K>;
> +            filter-level = <1>;
>              vdd-supply = <&vdd>;
>          };
>      };
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 6e9108d5cf75f..c1fe1e530786c 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -18,15 +18,23 @@
>  #include <linux/minmax.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <dt-bindings/iio/temperature/thermocouple.h>
>  
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  
>  /* MCP9600 registers */
> -#define MCP9600_HOT_JUNCTION 0x0
> -#define MCP9600_COLD_JUNCTION 0x2
> +#define MCP9600_HOT_JUNCTION		0x0
> +#define MCP9600_COLD_JUNCTION		0x2

Whitespace changes should also be in a separate patch to avoid
distraction from the actual changes.

>  #define MCP9600_STATUS			0x4
>  #define MCP9600_STATUS_ALERT(x)		BIT(x)
> +#define MCP9600_STATUS_OC_IR		BIT(4)
> +#define MCP9601_STATUS_SC		BIT(5)
> +#define MCP9600_SENSOR_CFG		0x5
> +#define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
> +#define MCP9600_SENSOR_TYPE(x)		((x << 4) & MCP9600_SENSOR_TYPE_MASK)

We typically avoid making macros like this and just use
FIELD_PREP() at the call site.

> +#define MCP9600_FILTER_MASK		GENMASK(2, 0)
> +#define MCP9600_FILTER(x)		((x << 0) & MCP9600_FILTER_MASK)
>  #define MCP9600_ALERT_CFG1		0x8
>  #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
>  #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> @@ -38,10 +46,11 @@
>  #define MCP9600_ALERT_LIMIT1		0x10
>  #define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
>  #define MCP9600_ALERT_LIMIT_MASK	GENMASK(15, 2)
> -#define MCP9600_DEVICE_ID 0x20
> +#define MCP9600_DEVICE_ID		0x20
>  
>  /* MCP9600 device id value */
> -#define MCP9600_DEVICE_ID_MCP9600 0x40
> +#define MCP9600_DEVICE_ID_MCP9600	0x40
> +#define MCP9600_DEVICE_ID_MCP9601	0x41
>  
>  #define MCP9600_ALERT_COUNT		4
>  
> @@ -58,6 +67,21 @@ enum mcp9600_alert {
>  	MCP9600_ALERT4
>  };
>  
> +static const unsigned int mcp9600_type_map[] = {
> +	[THERMOCOUPLE_TYPE_K] = 0,
> +	[THERMOCOUPLE_TYPE_J] = 1,
> +	[THERMOCOUPLE_TYPE_T] = 2,
> +	[THERMOCOUPLE_TYPE_N] = 3,
> +	[THERMOCOUPLE_TYPE_S] = 4,
> +	[THERMOCOUPLE_TYPE_E] = 5,
> +	[THERMOCOUPLE_TYPE_B] = 6,
> +	[THERMOCOUPLE_TYPE_R] = 7,
> +};
> +
> +static const int mcp9600_tc_types[] = {
> +	'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
> +};
> +
>  static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] = {
>  	[MCP9600_ALERT1] = "alert1",
>  	[MCP9600_ALERT2] = "alert2",
> @@ -87,8 +111,12 @@ static const struct iio_event_spec mcp9600_events[] = {
>  		{							       \
>  			.type = IIO_TEMP,				       \
>  			.address = MCP9600_HOT_JUNCTION,		       \
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
> -					      BIT(IIO_CHAN_INFO_SCALE),	       \
> +			.info_mask_separate =                                  \
> +					BIT(IIO_CHAN_INFO_RAW) |	       \
> +					BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
> +					BIT(IIO_CHAN_INFO_SCALE),              \
> +			.info_mask_separate_available =                        \
> +					BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE),  \

Since the type is set the the devicetree and can't be changed, there doesn't
seems much sense in listing the available types.

>  			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
>  			.num_event_specs = hj_num_ev,			       \
>  		},							       \
> @@ -125,6 +153,9 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
>  
>  struct mcp9600_data {
>  	struct i2c_client *client;
> +	unsigned char dev_id;

This isn't used outside of the probe function, so doesn't need to be here.

> +	u32 thermocouple_type;
> +	u32 filter;

filter_level

>  };
>  
>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -155,13 +186,82 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 62;
>  		*val2 = 500000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +		*val = mcp9600_tc_types[data->thermocouple_type];
> +		return IIO_VAL_CHAR;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9600_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +		return IIO_VAL_CHAR;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9600_config(struct mcp9600_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret, cfg;
> +
> +	cfg  = MCP9600_SENSOR_TYPE(mcp9600_type_map[data->thermocouple_type]) |
> +		MCP9600_FILTER(data->filter);
> +
> +	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to set sensor configuration\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp9600_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp9600_data *data = iio_priv(indio_dev);
> +	int tc_type = -1;
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:

Why would we want to write over what was set in the devicetree?

> +		for (i = 0; i < ARRAY_SIZE(mcp9600_tc_types); i++) {
> +			if (mcp9600_tc_types[i] == toupper(val)) {
> +				tc_type = i;
> +				break;
> +			}
> +		}
> +		if (tc_type < 0)
> +			return -EINVAL;
> +
> +		data->thermocouple_type = tc_type;
> +		ret = mcp9600_config(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		break;

return 0; here

> +
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	return 0;

rather than here

>  }
>  
>  static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
> @@ -299,12 +399,32 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int mcp9600_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +		*vals = mcp9600_tc_types;
> +		*type = IIO_VAL_CHAR;
> +		*length = ARRAY_SIZE(mcp9600_tc_types);
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct iio_info mcp9600_info = {
>  	.read_raw = mcp9600_read_raw,
> +	.write_raw = mcp9600_write_raw,
> +	.write_raw_get_fmt = mcp9600_write_raw_get_fmt,
>  	.read_event_config = mcp9600_read_event_config,
>  	.write_event_config = mcp9600_write_event_config,
>  	.read_event_value = mcp9600_read_thresh,
>  	.write_event_value = mcp9600_write_thresh,
> +	.read_avail = mcp9600_read_avail,
>  };
>  
>  static irqreturn_t mcp9600_alert_handler(void *private,
> @@ -418,26 +538,65 @@ static int mcp9600_probe(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev;
>  	struct mcp9600_data *data;
> -	int ret, ch_sel;
> +	int ch_sel, dev_id, ret;
>  
> -	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
> -	if (ret < 0)
> -		return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
> -	if (ret != MCP9600_DEVICE_ID_MCP9600)
> -		dev_warn(&client->dev, "Expected ID %x, got %x\n",
> -				MCP9600_DEVICE_ID_MCP9600, ret);
> +	dev_id = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
> +	if (dev_id < 0)
> +		return dev_err_probe(&client->dev, dev_id, "Failed to read device ID\n");
> +
> +	switch (dev_id) {
> +	case MCP9600_DEVICE_ID_MCP9600:
> +		dev_info(&client->dev, "Identified as mcp9600");
> +		break;
> +	case MCP9600_DEVICE_ID_MCP9601:
> +		dev_info(&client->dev, "Identified as mcp9601");
> +		break;
> +

Experience has show that depending on ICs to report the correct device ID
is fragile. Instead, we should depend on the compatible string. Printing
this for debug purposes is acceptable though, but should be a separate
patch. Just don't fail if it is an unexpected value.

> +	default:
> +		return dev_err_probe(&client->dev, -EINVAL, "Unknown device ID: %x\n",
> +				     dev_id);
> +	}
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +
> +	ret = device_property_read_u32(&client->dev, "thermocouple-type",
> +				       &data->thermocouple_type);
> +	if (ret) {
> +		dev_warn(&client->dev,
> +			 "Missing thermocouple-type property, using Type-K\n");

The devicetree bindings should have a default listed. So this should not be
a warning, but rather the expected default.

> +		data->thermocouple_type = THERMOCOUPLE_TYPE_K;
> +	} else if (data->thermocouple_type < 0 || data->thermocouple_type >=
> +		   ARRAY_SIZE(mcp9600_type_map)) {
> +		dev_warn(&client->dev,
> +			 "Invalid thermocouple-type property, using Type-K\n");

Should fail with error if the devicetree gives an invalid value.

> +		data->thermocouple_type = THERMOCOUPLE_TYPE_K;
> +	}
> +
> +	ret = device_property_read_u32(&client->dev, "filter-level",
> +				       &data->filter);
> +	if (ret) {
> +		dev_warn(&client->dev,
> +			 "Missing filter-level property, using 0\n");
> +		data->filter = 0;
> +	} else if (data->filter < 0 || data->filter > 7) {
> +		dev_warn(&client->dev,
> +			 "Invalid filter-level property, using 0\n");
> +		data->filter = 0;
> +	}
> +
> +	data->dev_id = dev_id;
>  	data->client = client;
>  
>  	ch_sel = mcp9600_probe_alerts(indio_dev);
>  	if (ch_sel < 0)
>  		return ch_sel;
>  
> +	mcp9600_config(data);
> +
>  	indio_dev->info = &mcp9600_info;
>  	indio_dev->name = "mcp9600";
>  	indio_dev->modes = INDIO_DIRECT_MODE;


