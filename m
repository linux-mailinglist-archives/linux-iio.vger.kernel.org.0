Return-Path: <linux-iio+bounces-24107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C010B57125
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 09:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD447AA80E
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA22D4B5F;
	Mon, 15 Sep 2025 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHY58iAW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFAC2D46BB;
	Mon, 15 Sep 2025 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920905; cv=none; b=QUFFjSs1K1o0tqactadjtWmdPtg0ayufP4/I96SzrMpsgaoTq1ixRtBuordNRZOHCLMqoDKcDsBhQT7cFnovw5dp6CURrbJjwBBWX2QDRswCOJWXdbaGTDvY2kdnkt39VCU3NK49MPExnEsbxeSZpysl8aQOoA4WhEg4a2PM75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920905; c=relaxed/simple;
	bh=hnQkfJdaz4J64XGVGqQUY0ejbNk1/Yb8gP67ZkFXXBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5ovKvvb+9zSU+cHSAZ8kjR+IzdXnhjyvFAXB7hXV6k579t7vOdwKIy01+okw5dr4mG25bBcfBSsijt5TCXVKDKqNowo3UF8ij4JSKCsdl4bsdP8wt23XMkH6T0ZMjs43LB8DMOBfgc4yegM3UWAW/Joo3GEsHaADQtbxYS59WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHY58iAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F823C4CEF1;
	Mon, 15 Sep 2025 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757920905;
	bh=hnQkfJdaz4J64XGVGqQUY0ejbNk1/Yb8gP67ZkFXXBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oHY58iAWzfDd5RwVm5RGOjcmd5USdQ+QfmR18QQR1nIDOxKJwqbt+shs4mVmG853F
	 dPGHWSfjE4EwUUd/nRuyq96KgbVQECfH7bEyDpp/8z7Qw2cm9vL+xDM3FG9W7+ro0w
	 +6XqvzKpU+FE627Jbr/uGhecbXZL+WxhR/+toHpL23yK3IwCRT0HLgJANLhoiF/Fqf
	 AFRviFn7klY3z7jaJXnB/m5oUQdiyw9jZL4ybPWCyn11eEIa6fjb2Ik5tXdIHn4Hbh
	 ZV1foFr/GqYas0ngZtS/oXIyTpWoIYMUZ5zivGnV9l3bq9rjUVrKOZi/StnVi1Wk9F
	 LaoeSI6zS6rvQ==
Message-ID: <7ed4b1ef-8eef-4acd-9ae6-6478d7c5ff29@kernel.org>
Date: Mon, 15 Sep 2025 09:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] counter: nxp-pcf85363-stopwatch: Add driver for NXP
 PCF85263/PCF85363 stopwatch
To: Lakshay Piplani <lakshay.piplani@nxp.com>, wbg@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com
References: <20250915071415.1956219-1-lakshay.piplani@nxp.com>
 <20250915071415.1956219-2-lakshay.piplani@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250915071415.1956219-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/09/2025 09:14, Lakshay Piplani wrote:
> +#include <linux/regmap.h>
> +#include <linux/counter.h>
> +#include <linux/cleanup.h>
> +#include <linux/bitfield.h>
> +#include <linux/nvmem-provider.h>
> +
> +#define SW_100THS	0x00
> +#define SW_SECS		0x01
> +#define SW_MINUTES	0x02
> +#define SW_HOURS_XX_XX_00	0x03
> +#define SW_HOURS_XX_00_XX	0x04
> +#define SW_HOURS_00_XX_XX	0x05
> +
> +#define CTRL_OFFSET	0x24
> +#define CTRL_OSCILLATOR	0x25
> +#define CTRL_BATTERY	0x26
> +#define CTRL_PIN_IO	0x27
> +#define CTRL_FUNCTION	0x28
> +#define CTRL_INTA_EN	0x29
> +#define CTRL_INTB_EN	0x2a
> +#define CTRL_FLAGS	0x2b
> +#define CTRL_RAMBYTE	0x2c
> +#define CTRL_WDOG	0x2d
> +#define CTRL_STOP_EN	0x2e
> +#define CTRL_RESETS	0x2f
> +#define CTRL_RAM	0x40
> +
> +#define OSC_CAP_SEL	GENMASK(1, 0)
> +#define OSC_CAP_6000	0x01
> +#define OSC_CAP_12500	0x02
> +
> +#define STOP_EN_STOP	BIT(0)
> +#define RTCM_BIT	BIT(4)
> +#define MODE_100TH_S	BIT(7)
> +#define SW_BCD7_MASK	GENMASK(6, 0)
> +
> +#define RESET_CPR	0xa4
> +
> +#define NVRAM_SIZE	0x40
> +
> +#define SW_MAX_100THS 359999999999ULL /* Maximum representable value in centiseconds (10ms)*/
> +
> +#define SW_TIME_REGS	6
> +
> +struct pcf85363 {
> +	struct regmap *regmap;
> +	struct counter_device *counter;
> +	struct mutex lock; /* Protects access to stopwatch registers */

regmap protects it already (see also further)
> +};
> +
> +struct pcf85x63_config {
> +	const struct regmap_config regmap;
> +	unsigned int num_nvram;
> +};
> +
> +static int pcf85363_load_capacitance(struct pcf85363 *pcf85363)
> +{
> +	struct device *dev = pcf85363->counter->parent;
> +	u32 load = 7000;
> +	u8 value = 0;
> +
> +	device_property_read_u32(dev, "quartz-load-femtofarads", &load);
> +
> +	switch (load) {
> +	default:
> +		dev_warn(pcf85363->counter->parent, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",

Missing wrapping. Please wrap around 80, so after parent, see Linux
coding style for proper explanation.

> +			 load);
> +		fallthrough;
> +	case 7000:
> +		break;
> +	case 6000:
> +		value = OSC_CAP_6000;
> +		break;
> +	case 12500:
> +		value = OSC_CAP_12500;
> +		break;
> +	}
> +
> +	return regmap_update_bits(pcf85363->regmap, CTRL_OSCILLATOR,
> +				  OSC_CAP_SEL, value);
> +}
> +
> +/* Reads stopwatch value in 1/100 seconds (centiseconds), the device stores

That's not netdev, so use standard Linux coding style comments.

> + * six BCD fields: CC(0..99), SS(0..59), MM(0..59), HH0/HH1/HH2 (each 0..99)
> + * Seconds and minutes contain OS/EMON flag bits; mask them as per datasheet
> + * before bcd2bin().
> + */
> +static int pcf85363_counter_read(struct counter_device *counter,
> +				 struct counter_count *count, u64 *val)
> +{
> +	struct pcf85363 *pcf85363 = counter_priv(counter);
> +	u8 raw[SW_TIME_REGS];
> +	u64 hours;
> +	int ret;
> +
> +	guard(mutex)(&pcf85363->lock);
> +	ret = regmap_bulk_read(pcf85363->regmap, SW_100THS, raw, ARRAY_SIZE(raw));
> +	if (ret)
> +		return ret;
> +

So the lock would end here if you were protecting registers. Your
comment about locking is misleading or incomplete or incorrect.

> +	/* Mask OS/EMON flag bits in seconds/minutes */
> +	raw[1] = FIELD_GET(SW_BCD7_MASK, raw[1]);
> +	raw[2] = FIELD_GET(SW_BCD7_MASK, raw[2]);
> +
> +	hours = (u64)bcd2bin(raw[3]);
> +	hours += (u64)bcd2bin(raw[4]) * 100ULL;
> +	hours += (u64)bcd2bin(raw[5]) * 10000ULL;
> +
> +	*val = (u64)bcd2bin(raw[0]);
> +	*val += (u64)bcd2bin(raw[1]) * 100ULL;
> +	*val += (u64)bcd2bin(raw[2]) * 60ULL * 100ULL;
> +	*val += hours * 60ULL * 60ULL * 100ULL;
> +
> +	/* Defensive clamp in case of transient read while rolling over */
> +	if (*val > SW_MAX_100THS) {
> +		dev_warn(counter->parent, "stopwatch value exceeds max, clamping\n");
> +		*val = SW_MAX_100THS;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Set stopwatch value in centiseconds. It requires a stop-load-start sequence.
> + * set STOP_EN, write all six BCD fields then clear STOP_EN.
> + */
> +static int pcf85363_counter_write(struct counter_device *counter,
> +				  struct counter_count *count, const u64 val)
> +{
> +	struct pcf85363 *pcf85363 = counter_priv(counter);
> +	u64 rem = val;
> +	u8 buf[SW_TIME_REGS];
> +	int ret;
> +
> +	if (val > SW_MAX_100THS)
> +		return -ERANGE;
> +
> +	buf[0] = bin2bcd(rem % 100); rem /= 100;
> +	buf[1] = bin2bcd(rem % 60); rem /= 60;
> +	buf[2] = bin2bcd(rem % 60); rem /= 60;
> +	buf[3] = bin2bcd(rem % 100); rem /= 100;
> +	buf[4] = bin2bcd(rem % 100); rem /= 100;
> +	buf[5] = bin2bcd(rem % 100);
> +
> +	guard(mutex)(&pcf85363->lock);
> +	ret = regmap_update_bits(pcf85363->regmap, CTRL_STOP_EN, STOP_EN_STOP,
> +				 FIELD_PREP(STOP_EN_STOP, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(pcf85363->regmap, SW_100THS, buf, ARRAY_SIZE(buf));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(pcf85363->regmap, CTRL_STOP_EN, STOP_EN_STOP,
> +				 FIELD_PREP(STOP_EN_STOP, 0));
> +
> +	return ret;
> +}
> +
> +static int pcf85363_counter_is_enabled(struct counter_device *counter,
> +					struct counter_count *count, u8 *enable)
> +{
> +	struct pcf85363 *pcf85363 = counter_priv(counter);
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&pcf85363->lock);
> +	ret = regmap_read(pcf85363->regmap, CTRL_STOP_EN, &val);
> +	if (ret)
> +		return ret;
> +
> +	*enable = !FIELD_GET(STOP_EN_STOP, val);
> +
> +	return 0;
> +}
> +
> +static int pcf85363_counter_set_enable(struct counter_device *counter,
> +					 struct counter_count *count, u8 enable)
> +{
> +	struct pcf85363 *pcf85363 = counter_priv(counter);
> +
> +	guard(mutex)(&pcf85363->lock);
> +
> +	return regmap_update_bits(pcf85363->regmap, CTRL_STOP_EN,
> +				  STOP_EN_STOP, FIELD_PREP(STOP_EN_STOP, enable ? 0 : 1));
> +}
> +
> +static const struct counter_ops pcf85363_counter_ops = {
> +	.count_read = pcf85363_counter_read,
> +	.count_write = pcf85363_counter_write,
> +};
> +
> +static struct counter_comp pcf85363_counter_ext[] = {
> +	COUNTER_COMP_ENABLE(pcf85363_counter_is_enabled,
> +			    pcf85363_counter_set_enable),
> +};
> +
> +static struct counter_count pcf85363_counts[] = {
> +	{
> +		.id = 0,
> +		.name = "pcf85363-stopwatch",
> +		.functions_list = (const enum counter_function[]){
> +		COUNTER_FUNCTION_INCREASE },
> +		.num_functions = 1,
> +		.ext = pcf85363_counter_ext,
> +		.num_ext = ARRAY_SIZE(pcf85363_counter_ext),
> +	}
> +};
> +
> +static int pcf85363_nvram_read(void *priv, unsigned int offset, void *val,
> +			       size_t bytes)
> +{
> +	struct pcf85363 *pcf85363 = priv;
> +
> +	guard(mutex)(&pcf85363->lock);
> +
> +	return regmap_bulk_read(pcf85363->regmap, CTRL_RAM + offset,
> +				val, bytes);
> +}
> +
> +static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
> +				size_t bytes)
> +{
> +	struct pcf85363 *pcf85363 = priv;
> +
> +	guard(mutex)(&pcf85363->lock);
> +
> +	return regmap_bulk_write(pcf85363->regmap, CTRL_RAM + offset,
> +				 val, bytes);
> +}
> +
> +static int pcf85x63_nvram_read(void *priv, unsigned int offset, void *val,
> +			       size_t bytes)
> +{
> +	struct pcf85363 *pcf85363 = priv;
> +	unsigned int tmp_val;
> +	int ret;
> +
> +	guard(mutex)(&pcf85363->lock);
> +
> +	ret = regmap_read(pcf85363->regmap, CTRL_RAMBYTE, &tmp_val);
> +	(*(unsigned char *)val) = (unsigned char)tmp_val;
> +
> +	return ret;
> +}
> +
> +static int pcf85x63_nvram_write(void *priv, unsigned int offset, void *val,
> +				size_t bytes)
> +{
> +	struct pcf85363 *pcf85363 = priv;
> +	unsigned char tmp_val;
> +
> +	guard(mutex)(&pcf85363->lock);
> +
> +	tmp_val = *((unsigned char *)val);
> +	return regmap_write(pcf85363->regmap, CTRL_RAMBYTE,
> +				(unsigned int)tmp_val);
> +}
> +
> +static const struct pcf85x63_config pcf_85263_config = {
> +	.regmap = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = 0x2f,
> +	},
> +	.num_nvram = 1
> +};
> +
> +static const struct pcf85x63_config pcf_85363_config = {
> +	.regmap = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = 0x7f,
> +	},
> +	.num_nvram = 2
> +};
> +
> +static const struct nvmem_config nvmem_cfgs[] = {
> +	{
> +		.name = "pcf85x63-",
> +		.word_size = 1,
> +		.stride = 1,
> +		.size = 1,
> +		.reg_read = pcf85x63_nvram_read,
> +		.reg_write = pcf85x63_nvram_write,
> +	}, {
> +		.name = "pcf85363-",
> +		.word_size = 1,
> +		.stride = 1,
> +		.size = NVRAM_SIZE,
> +		.reg_read = pcf85363_nvram_read,
> +		.reg_write = pcf85363_nvram_write,
> +	},
> +};
> +
> +static int pcf85363_stopwatch_probe(struct i2c_client *client)
> +{
> +	struct pcf85363 *pcf85363;
> +	const struct pcf85x63_config *config = &pcf_85363_config;

Drop this assignment, not correct.

> +	const void *data = of_device_get_match_data(&client->dev);

Drop, pointless.

> +	struct device *dev = &client->dev;
> +	struct nvmem_device *nvmem;
> +	int ret, i, err;
> +
> +	if (data)
> +		config = data;

You only need the assignment here data = get_match_data.

> +
> +	struct counter_device *counter = devm_counter_alloc(dev, sizeof(struct pcf85363));
> +
> +	if (!counter)
> +		return -ENOMEM;
> +
> +	pcf85363 = counter_priv(counter);
> +
> +	mutex_init(&pcf85363->lock);
> +
> +	pcf85363->regmap = devm_regmap_init_i2c(client, &config->regmap);
> +	if (IS_ERR(pcf85363->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pcf85363->regmap), "regmap init failed\n");
> +
> +	/* Stopwatch Mode set and centiseconds granularity enabled */
> +	ret = regmap_update_bits(pcf85363->regmap, CTRL_FUNCTION,
> +				 RTCM_BIT | MODE_100TH_S, RTCM_BIT | MODE_100TH_S);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set RTCM bit\n");
> +
> +	ret = regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to clear flags\n");
> +
> +	counter->name = "pcf85363-stopwatch";
> +	counter->parent = dev;
> +	counter->ops = &pcf85363_counter_ops;
> +	counter->counts = pcf85363_counts;
> +	counter->num_counts = ARRAY_SIZE(pcf85363_counts);
> +	pcf85363->counter = counter;
> +
> +	ret = devm_counter_add(dev, counter);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Counter registration failed\n");
> +
> +	dev_dbg(dev, "pcf85363 registered in stopwatch mode\n");
> +
> +	err = pcf85363_load_capacitance(pcf85363);
> +	if (err < 0)
> +		dev_warn(&client->dev, "failed to set xtal load capacitance: %d", err);
> +
> +	for (i = 0; i < config->num_nvram; i++) {
> +		struct nvmem_config cfg = nvmem_cfgs[i];
> +
> +		cfg.priv = pcf85363;
> +		cfg.dev = dev;
> +		cfg.id = i;
> +		nvmem = devm_nvmem_register(dev, &cfg);
> +		if (IS_ERR(nvmem))
> +			return dev_err_probe(dev, PTR_ERR(nvmem), "nvmem reg %d failed\n", i);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dev_ids[] = {
> +	{ .compatible = "nxp,pcf85263atl", .data = &pcf_85263_config },
> +	{ .compatible = "nxp,pcf85363atl", .data = &pcf_85363_config },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dev_ids);
> +
> +static struct i2c_driver pcf85363_sw_driver = {
> +	.driver	= {
> +		.name	= "pcf85363-stopwatch",
> +		.of_match_table = of_match_ptr(dev_ids),

You have warnings here, drop of_match_ptr. There is no such combination
in mainline anymore, we fixed it some time ago.

> +	},
> +	.probe = pcf85363_stopwatch_probe,
> +};
> +
> +module_i2c_driver(pcf85363_sw_driver);
> +
> +MODULE_AUTHOR("Lakshay Piplani");
> +MODULE_DESCRIPTION("pcf85263/pcf85363 stopwatch driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("COUNTER");


Best regards,
Krzysztof

