Return-Path: <linux-iio+bounces-12665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D66229D8E1E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 22:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91388B24829
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 21:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176A1BFE0C;
	Mon, 25 Nov 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LowJag8m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618861CD2C;
	Mon, 25 Nov 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570090; cv=none; b=DLVhcWUs8s7zO4xkP5NgUh9d9Ipg7BY6ycASC9wpwNAuayBiazYn8rxpAgwUUzjqVI/fGhKCdEIBhXBvPUGvljr0aVysenZRjZHTUK5c2jzHagmbOLu+MjShJdReMqwV7UFof1PzBD5mKv/RoZKxEDTle58gd14FkoQk/Yg9JKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570090; c=relaxed/simple;
	bh=etI98zGp0yYxjqxGidygR23i/FaxiFLzlc0RMySm7o0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUJADOMZnMz41ORIexaOn4hRBKo/aXsW2f5GODVBCRP8QsZG//1oATYHPpavCcheQ0n2f1K05moNhe+qNypRRpreBPnFQPoNy8I1j/pc+AqDbkUGjM+qVu2ZqmUz83jUZOZb3eVQVWPnIy9gb8kqBKKcB+60i7jb2M+a58kjBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LowJag8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5385CC4CECE;
	Mon, 25 Nov 2024 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732570090;
	bh=etI98zGp0yYxjqxGidygR23i/FaxiFLzlc0RMySm7o0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LowJag8mUTwgfhoUFZwm0mZPP5EwCVzay+fDxmlGMLXR3ldrIcuKq/BWanWoZtZLo
	 sJ9ZVckoUG9ysbPEOhLfiCF8NONE8qenBrR2/MGLFpEXLkzqDcZF8yv5+JgKe84eJJ
	 2bdih0qdzese8fIM3nkp6l7Yc7fnaDhIFilpjkmxNSN9GZ09femKS/WrGMEeRKqf8+
	 jiiG/lOIcNABUosOzF8R87P3S0EeevVadvTs0lwXTDN7UEPzEpFeG0R1Ly4CTQvoGH
	 q6cNXm+/8ViPiu2A6jYOFRFuIW6kbDJ7A+sW2HRgaBAdKjeRtMgyT1Q9dlJsgMl3EQ
	 bIV/cZwbk+unA==
Date: Mon, 25 Nov 2024 21:28:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: Add ADF4382
Message-ID: <20241125212801.49efb3cf@jic23-huawei>
In-Reply-To: <20241114130340.7354-3-ciprian.hegbeli@analog.com>
References: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
	<20241114130340.7354-3-ciprian.hegbeli@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 15:03:11 +0200
Ciprian Hegbeli <ciprian.hegbeli@analog.com> wrote:

> The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
> with integrated VCO ideally suited for LO generation for 5G applications
> or data converter clock applications. The high performance
> PLL has a figure of merit of -239 dBc/Hz, low 1/f Noise and
> high PFD frequency of 625MHz in integer mode that can achieve
> ultralow in-band noise and integrated jitter. The ADF4382A can
> generate frequencies in a fundamental octave range of 11.5 GHz to
> 21 GHz, thereby eliminating the need for sub-harmonic filters. The
> divide by 2 and 4 output dividers on the part allow frequencies to
> be generated from 5.75GHz to 10.5GHz and 2.875GHz to 5.25GHz
> respectively.
Hi Ciprian,

No real need to repeat all of this.  Perhaps a shorter version
for this patch, or something about what features are implemented instead
of so much device info.

Various questions and comments inline.  In some cases I have picked
out some examples of a particular code platform, please generalize and
apply to all similar code for v2.

Thanks,

Jonathan

> +#define ADF4382_CP_I_DEFAULT			15
> +#define ADF4382_OPOWER_DEFAULT			11
> +#define ADF4382_REF_DIV_DEFAULT			1
> +#define ADF4382_RFOUT_DEFAULT			2875000000ULL	// 2.875GHz
Maybe express as 2875ULL * MEGA
Same for other cases. No one likes counting zeros if we an avoid it!

/* */ for comments.

If long lines, put them above the thing you are talking about.

> +#define ADF4382_SCRATCHPAD_VAL			0xA5
> +
> +#define ADF4382_PHASE_BLEED_CNST_MUL		511
Non obvious, so good to have some hints on why these values, perhaps a spec reference.
> +#define ADF4382_PHASE_BLEED_CNST_DIV		285
> +#define ADF4382_VCO_CAL_CNT			202
> +#define ADF4382_VCO_CAL_VTUNE			124
> +#define ADF4382_VCO_CAL_ALC			250
> +
> +#define FS_PER_NS				MICRO

These should be in units.h if they are useful.
Or calculate them from what is there. E.g.
replace NS_PER_MS with NANO / MILLI

> +#define NS_PER_MS				MICRO
> +#define MS_PER_NS				MICRO
> +#define NS_PER_FS				MICRO
> +#define PS_PER_NS				1000
> +#define UA_PER_A				1000000
> +
> +#define PERIOD_IN_DEG				360
> +#define PERIOD_IN_DEG_MS			360000
> +
> +#ifdef CONFIG_64BIT
> +#define ADF4382_CLK_SCALE			1
> +#else
> +#define	ADF4382_CLK_SCALE			10ULL
> +#endif

No to this.  Make the maths work either way as this just makes the
code hard to read.  We don't really care about 32bit much any more
so just use the relevant handlers and 64 bit maths. It will slower
on a 32bit system but we don't care.

If this is about the int size of val and val2, just assume 32 bit
always and make sure what you use fits.



> +
> +enum {
> +	ADF4382_FREQ,
> +	ADF4382_EN_AUTO_ALIGN,
This should go away - see later.

> +};
> +
> +enum {
> +	ADF4382,
> +	ADF4382A,
As below, this sort of enum usually indicates that there is code to deal
with the difference between variants, which instead should be done with data
via appropriate static const struct picking.

> +};
> +
> +struct adf4382_state {
> +	struct spi_device	*spi;
> +	struct regmap		*regmap;
> +	struct clk		*clkin;
> +	struct clk		*clkout;
> +	struct clk_hw		clk_hw;
> +	/* Protect against concurrent accesses to the device and data content */
Good to be more specific. I'm guessing there are read modify write sequences
or things that must be read sequentially that are not protected by
the regmap locking.

> +	struct mutex		lock;
> +	struct notifier_block	nb;
> +	unsigned int		ref_freq_hz;
> +	u8			cp_i;
> +	u8			opwr_a;
> +	u64			freq;
> +	bool			spi_3wire_en;
> +	bool			ref_doubler_en;
> +	bool			auto_align_en;
> +	u8			ref_div;
> +	u8			clkout_div_reg_val_max;
> +	u16			bleed_word;
> +	int			phase;
> +	bool			cmos_3v3;
> +	u64			vco_max;
> +	u64			vco_min;
> +};
> +
> +#define to_adf4382_state(_hw) container_of(_hw, struct adf4382_state, clk_hw)
> +
> +/* Charge pump current values expressed in uA */
> +static const int adf4382_ci_ua[] = {
> +	790, 990, 1190, 1380, 1590, 1980, 2390, 2790, 3180, 3970, 4770, 5570,
> +	6330, 7910, 9510, 11100

Wrap after 8 values, it makes it easier to find a particular one.
Feel free to add some spaces to align the two rows.

> +};
> +
> +static const struct reg_sequence adf4382_reg_default[] = {
> +	{ 0x00a, 0xA5 }, { 0x200, 0x00 }, { 0x201, 0x00 }, { 0x202, 0x00 },
> +	{ 0x203, 0x00 }, { 0x203, 0x00 }, { 0x203, 0x00 }, { 0x100, 0x25 },
> +	{ 0x101, 0x3F }, { 0x102, 0x3F }, { 0x103, 0x3F }, { 0x104, 0x3F },
> +	{ 0x105, 0x3F }, { 0x106, 0x3F }, { 0x107, 0x3F }, { 0x108, 0x3F },
> +	{ 0x109, 0x25 }, { 0x10A, 0x25 }, { 0x10B, 0x3F }, { 0x10C, 0x3F },
> +	{ 0x10D, 0x3F }, { 0x10E, 0x3F }, { 0x10F, 0x3F }, { 0x110, 0x3F },
> +	{ 0x111, 0x3F }, { 0x054, 0x00 }, { 0x053, 0x45 }, { 0x052, 0x00 },
> +	{ 0x051, 0x00 }, { 0x050, 0x00 }, { 0x04f, 0x08 }, { 0x04e, 0x06 },
> +	{ 0x04d, 0x00 }, { 0x04c, 0x2B }, { 0x04b, 0x5D }, { 0x04a, 0x00 },
> +	{ 0x048, 0x00 }, { 0x047, 0x00 }, { 0x046, 0x00 }, { 0x045, 0x62 },
> +	{ 0x044, 0x3F }, { 0x043, 0xB8 }, { 0x042, 0x01 }, { 0x041, 0x00 },
> +	{ 0x040, 0x00 }, { 0x03f, 0x82 }, { 0x03e, 0x4E }, { 0x03c, 0x00 },
> +	{ 0x03b, 0x00 }, { 0x03a, 0xFA }, { 0x039, 0x00 }, { 0x038, 0x71 },
> +	{ 0x037, 0x82 }, { 0x036, 0xC0 }, { 0x035, 0x00 }, { 0x034, 0x36 },
> +	{ 0x033, 0x00 }, { 0x032, 0x40 }, { 0x031, 0x63 }, { 0x030, 0x0F },
> +	{ 0x02f, 0x3F }, { 0x02e, 0x00 }, { 0x02d, 0xF1 }, { 0x02c, 0x0E },
> +	{ 0x02b, 0x01 }, { 0x02a, 0x30 }, { 0x029, 0x09 }, { 0x028, 0x00 },
> +	{ 0x027, 0xF0 }, { 0x026, 0x00 }, { 0x025, 0x01 }, { 0x024, 0x01 },
> +	{ 0x023, 0x00 }, { 0x022, 0x00 }, { 0x021, 0x00 }, { 0x01e, 0x20 },
> +	{ 0x01d, 0x00 }, { 0x01c, 0x00 }, { 0x01b, 0x00 }, { 0x01a, 0x00 },
> +	{ 0x019, 0x00 }, { 0x018, 0x00 }, { 0x017, 0x00 }, { 0x016, 0x00 },
> +	{ 0x015, 0x06 }, { 0x014, 0x00 }, { 0x013, 0x00 }, { 0x012, 0x00 },
> +	{ 0x011, 0x00 }, { 0x010, 0x50 }

Where possible build these up from appropriate defines of the fields.
Will take more code, but give a ready way to see what default means and
compare with functions that change it.

> +};

> +
> +static int _adf4382_set_freq(struct adf4382_state *st)
> +{
> +	u32 frac2_word = 0;
> +	u32 mod2_word = 0;
> +	u64 pfd_freq_hz;
> +	u32 frac1_word;
> +	u8 clkout_div;
> +	u32 read_val;
> +	u8 dclk_div1;
> +	u8 int_mode;
> +	u8 en_bleed;
> +	u8 ldwin_pw;
> +	u16 n_int;
> +	u8 div1;
> +	u64 tmp;
> +	u64 vco;
As below, combine same types to shorten the code.

> +	int ret;
> +	u8 var;
> +
> +	ret = adf4382_pfd_compute(st, &pfd_freq_hz);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "PFD frequency is out of range.\n");
> +		return ret;
> +	}
> +
> +	for (clkout_div = 0; clkout_div <= st->clkout_div_reg_val_max; clkout_div++) {
> +		tmp =  (1 << clkout_div) * st->freq;
> +		if (tmp < st->vco_min || tmp > st->vco_max)
> +			continue;
> +
> +		vco = tmp;
> +		break;
> +	}
> +
> +	if (vco == 0) {

more conventional might be to check if the clk_out_dev > st->clk_out_div_reg_val_max;
Then no ned to init vco (which it seems you don't but should have).


> +		dev_err(&st->spi->dev, "Output frequency is out of range.\n");
> +		ret = -EINVAL;
> +		return ret;
> +	}
> +
> +	ret = adf4382_pll_fract_n_compute(st, pfd_freq_hz, &n_int, &frac1_word,
> +					  &frac2_word, &mod2_word);
> +	if (ret)
> +		return ret;
> +
> +	if (frac1_word || frac2_word) {
> +		int_mode = 0;
> +		en_bleed = 1;
> +
> +		if (pfd_freq_hz <= (40 * HZ_PER_MHZ)) {
> +			ldwin_pw = 7;
> +		} else if (pfd_freq_hz <= (50 * HZ_PER_MHZ)) {
> +			ldwin_pw = 6;
> +		} else if (pfd_freq_hz <= (100 * HZ_PER_MHZ)) {
> +			ldwin_pw = 5;
> +		} else if (pfd_freq_hz <= (200 * HZ_PER_MHZ)) {
> +			ldwin_pw = 4;
> +		} else if (pfd_freq_hz <= (250 * HZ_PER_MHZ)) {
> +			if (st->freq >= (5000U * HZ_PER_MHZ) &&
> +			    st->freq < (6400U * HZ_PER_MHZ)) {
> +				ldwin_pw = 3;
> +			} else {
> +				ldwin_pw = 2;
> +			}
> +		}
> +	} else {
> +		int_mode = 1;
> +		en_bleed = 0;
> +
> +		tmp = DIV_ROUND_UP_ULL(pfd_freq_hz, UA_PER_A);
> +		tmp *= adf4382_ci_ua[st->cp_i];
> +		tmp = DIV_ROUND_UP_ULL(st->bleed_word, tmp);
> +		if (tmp <= 85)
> +			ldwin_pw = 0;
> +		else
> +			ldwin_pw = 1;
> +	}
> +
> +	dev_dbg(&st->spi->dev,
> +		"VCO=%llu PFD=%llu RFout_div=%u N=%u FRAC1=%u FRAC2=%u MOD2=%u\n",
> +		vco, pfd_freq_hz, 1 << clkout_div, n_int,
> +		frac1_word, frac2_word, mod2_word);
> +
> +	ret = regmap_update_bits(st->regmap, 0x28, ADF4382_VAR_MOD_EN_MSK,
> +				 frac2_word != 0 ? 0xff : 0);

Use MOD_EN_MSK again, not 0xff.  Or use an if else with set_bits and clear_bits


> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, 0x15, ADF4382_INT_MODE_MSK,
> +				 FIELD_PREP(ADF4382_INT_MODE_MSK, int_mode));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, 0x1D,
> +			   FIELD_GET(ADF4382_BLEED_I_LSB_MSK, st->bleed_word));
> +	if (ret)
> +		return ret;
> +
> +	var = (st->bleed_word >> 8) & ADF4382_BLEED_I_MSB_MSK;
> +	ret = regmap_update_bits(st->regmap, 0x1E, ADF4382_BLEED_I_MSB_MSK, var);
> +	if (ret)
> +		return ret;
> +	ret = regmap_update_bits(st->regmap, 0x1F, ADF4382_EN_BLEED_MSK,
> +				 FIELD_PREP(ADF4382_EN_BLEED_MSK, en_bleed));
> +	if (ret)
> +		return ret;
> +

Use a bulk write and a put_unaligned_l/be24()


> +	return 0;
> +}
> +
> +static int adf4382_set_freq(struct adf4382_state *st)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = _adf4382_set_freq(st);
> +	mutex_unlock(&st->lock);
guard(mutex)(&st->lock);
return _adf...

> +
> +	return ret;
> +}
> +
> +static int adf4382_get_freq(struct adf4382_state *st, u64 *val)
> +{
> +	unsigned int tmp;
> +	u32 frac1 = 0;
> +	u32 frac2 = 0;
> +	u32 mod2 = 0;
> +	u64 freq;
> +	u64 pfd;
Combine same types on oneline - don't mix ones that set the value and
ones that don't however.

> +	u16 n;
> +	int ret;
> +
> +	ret = adf4382_pfd_compute(st, &pfd);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, 0x11, &tmp);
> +	if  (ret)
> +		return ret;
> +
> +	n = FIELD_PREP(ADF4382_N_INT_MSB_MSK, tmp);
> +	n = n << 8;
> +
> +	ret = regmap_read(st->regmap, 0x10, &tmp);
> +	if  (ret)
> +		return ret;
> +	n |= FIELD_PREP(ADF4382_N_INT_LSB_MSK, tmp);
Looks like a bulk read and an endian. Check for all these
and replace them with that approach.

> +	ret = regmap_read(st->regmap, 0x1c, &tmp);
Looks like a bulk read of 3 bytes then a get_unaligned_be24
or similar. Be careful with dma safety of buffers when
switching to bulkd read.

> +	if  (ret)
> +		return ret;
> +	mod2 |= FIELD_PREP(ADF4382_MOD2WORD_MSB_MSK, tmp);
> +
> +	ret = regmap_read(st->regmap, 0x1b, &tmp);
> +	if  (ret)
> +		return ret;
> +	mod2 |= FIELD_PREP(ADF4382_MOD2WORD_MID_MSK, tmp);
> +
> +	ret = regmap_read(st->regmap, 0x1a, &tmp);
> +	if  (ret)
> +		return ret;
> +	mod2 |= FIELD_PREP(ADF4382_MOD2WORD_LSB_MSK, tmp);
> +
> +	if (mod2 == 0)
> +		mod2 = 1;
> +
> +	freq = frac2 * pfd;
> +	freq = div_u64(freq, mod2);
> +	freq = freq + (frac1 * pfd);
> +	freq = div_u64(freq, ADF4382_MOD1WORD);
> +	freq = freq + (n * pfd);
> +
> +	*val = freq;
> +	return 0;
> +}
> +
> +static int adf4382_set_phase_adjust(struct adf4382_state *st, u32 phase_fs)
> +{
> +	u8 phase_reg_value;
> +	u64 phase_deg_fs;
> +	u64 phase_deg_ns;
> +	u64 phase_deg_ms;
> +	u64 phase_bleed;
> +	u64 phase_value;
> +	u64 pfd_freq_hz;
> +	u64 phase_ci;
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, 0x1E, ADF4382_EN_PHASE_RESYNC_MSK,
> +				 0xff);

regmap_set_bits? Using 0xff when only one bit set is not easy to read.
Also breaks the scripting that is out there to detect when regmap_set_bits should
be used for simpler and clearer code.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, 0x1F, ADF4382_EN_BLEED_MSK, 0xff);
regmap_set_bits? 
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, 0x32, ADF4382_DEL_MODE_MSK, 0x0);
regmap_clear_bits

> +	if (ret)
> +		return ret;
> +
> +	ret = adf4382_pfd_compute(st, &pfd_freq_hz);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "PFD frequency is out of range.\n");
> +		return ret;
> +	}
> +
> +	// Determine the phase adjustment in degrees relative the output freq.
> +	phase_deg_fs = phase_fs * st->freq;
> +	phase_deg_ns = div_u64(phase_deg_fs, FS_PER_NS);
> +	phase_deg_ns = PERIOD_IN_DEG * phase_deg_ns;

That PERIOD_IN_DEG rather implies that some of these were not phase_deg.

I don't really understand the steps here. Maybe add a comment with the maths
would help.

> +	phase_deg_ms = div_u64(phase_deg_ns, NS_PER_MS);
> +
> +	if (phase_deg_ms > PERIOD_IN_DEG_MS) {
> +		dev_err(&st->spi->dev, "Phase adjustment is out of range.\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The charge pump current will also need to be taken in to account
> +	 * as well as the Bleed constant
> +	 */
> +	phase_ci = phase_deg_ms * adf4382_ci_ua[st->cp_i];
> +	phase_bleed = phase_ci * ADF4382_PHASE_BLEED_CNST_MUL;
> +	phase_bleed = div_u64(phase_bleed, ADF4382_PHASE_BLEED_CNST_DIV);
> +
> +	// Computation of the register value for the phase adjust
> +	phase_value = phase_bleed * pfd_freq_hz;
> +	phase_value = div64_u64(phase_value, st->freq);
> +	phase_value = div_u64(phase_value, PERIOD_IN_DEG);
> +	phase_value = DIV_ROUND_CLOSEST_ULL(phase_value, MILLI);
> +
> +	// Mask the value to 8 bits

All comments in IIO use /* */

> +	phase_reg_value = phase_value & 0xff;
> +
> +	ret = regmap_write(st->regmap, 0x33, phase_reg_value);
> +	if (ret)
> +		return ret;
> +
> +	if (st->auto_align_en)
> +		return regmap_update_bits(st->regmap, 0x32,
> +					  ADF4382_EN_AUTO_ALIGN_MSK, 0xff);
> +
> +	ret = regmap_update_bits(st->regmap, 0x32, ADF4382_EN_AUTO_ALIGN_MSK, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, 0x34, ADF4382_PHASE_ADJ_MSK, 0xff);
> +}
> +
> +static int adf4382_get_phase_adjust(struct adf4382_state *st, u32 *val)
> +{
> +	unsigned int tmp;
> +	u8 phase_reg_value;
> +	u64 phase_value;
> +	u64 pfd_freq_hz;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, 0x33, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	phase_reg_value = tmp;
> +
> +	ret = adf4382_pfd_compute(st, &pfd_freq_hz);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "PFD frequency is out of range.\n");
> +		return ret;
> +	}
> +
> +	phase_value = phase_reg_value * PERIOD_IN_DEG;

Clear the intermediates are not phase_value.  Can we figure a naming
scheme out that makes the intermediate steps more obvious.

> +	phase_value = phase_value * st->freq;

	phase_value = phase_reg_value * PERIOD_IN_DEG * st->freq;

> +	phase_value = div64_u64(phase_value, pfd_freq_hz);
> +
> +	phase_value = phase_value * ADF4382_PHASE_BLEED_CNST_DIV;
> +	phase_value = phase_value * MS_PER_NS;

	phase_value *= ADF4382_PHASE_BLEED_CNST_DIV * MS_PER_NS;

> +	phase_value = div_u64(phase_value, ADF4382_PHASE_BLEED_CNST_MUL);
> +	phase_value = phase_value * MILLI;
	phase_value *= MILLI;

> +	phase_value = div_u64(phase_value, adf4382_ci_ua[st->cp_i]);
> +
> +	phase_value = phase_value * NS_PER_FS;
*= here as well.

> +	phase_value = div_u64(phase_value, PERIOD_IN_DEG);
> +	phase_value = div64_u64(phase_value, st->freq);
> +
> +	*val = (u32)phase_value;
> +
> +	return 0;
> +}

> +
> +static int adf4382_set_en_chan(struct adf4382_state *st, int ch, int en)
> +{
> +	if (!ch) {
> +		return regmap_update_bits(st->regmap, 0x2B,
> +					  ADF4382_PD_CLKOUT1_MSK,
> +					  FIELD_PREP(ADF4382_PD_CLKOUT1_MSK, !en));
> +	}
for cases like this where it is a choice between 0 and 1, I'd use an else
even though not necessary for correctness.
> +
> +	return regmap_update_bits(st->regmap, 0x2B, ADF4382_PD_CLKOUT2_MSK,
> +				  FIELD_PREP(ADF4382_PD_CLKOUT2_MSK, !en));
> +}
> +
> +static int adf4382_get_en_chan(struct adf4382_state *st, int ch, int *en)
> +{
> +	int enable;
> +
> +	if (!ch)
> +		enable = regmap_test_bits(st->regmap, 0x2B,
> +					  ADF4382_PD_CLKOUT1_MSK);
> +	else
> +		enable = regmap_test_bits(st->regmap, 0x2B,
> +					  ADF4382_PD_CLKOUT2_MSK);
> +	if (enable < 0)
> +		return enable;
> +
> +	*en = !enable;

That's certainly novel!  Rename enable to disable.

> +	return 0;
> +}
> +
> +static ssize_t adf4382_write(struct iio_dev *indio_dev, uintptr_t private,
> +			     const struct iio_chan_spec *chan, const char *buf,
> +			     size_t len)
> +{
> +	struct adf4382_state *st = iio_priv(indio_dev);
> +	unsigned long long val;
> +	int ret;
> +
> +	ret = kstrtoull(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	switch ((u32)private) {
> +	case ADF4382_FREQ:
> +		st->freq = val;
> +		ret = adf4382_set_freq(st);
As below, overlap in code doesn't warrant having a single write function.

> +		break;
> +	case ADF4382_EN_AUTO_ALIGN:
> +		st->auto_align_en = !!val;
> +		ret = adf4382_set_phase_adjust(st, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t adf4382_read(struct iio_dev *indio_dev, uintptr_t private,
> +			    const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct adf4382_state *st = iio_priv(indio_dev);
> +	unsigned int val = 0;
> +	u64 val_u64 = 0;
> +	int ret;
> +
> +	switch ((u32)private) {
> +	case ADF4382_FREQ:
> +		ret = adf4382_get_freq(st, &val_u64);
There is almost no overlap, so just have separate callbacks.

> +		if (ret)
> +			return ret;
> +		return sysfs_emit(buf, "%llu\n", val_u64);
> +	case ADF4382_EN_AUTO_ALIGN:
> +		ret = regmap_read(st->regmap, 0x32, &val);
> +		if (ret)
> +			return ret;
> +		return sysfs_emit(buf, "%lu\n",
> +				  FIELD_GET(ADF4382_EN_AUTO_ALIGN_MSK, val));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define _ADF4382_EXT_INFO(_name, _shared, _ident) { \
> +		.name = _name, \
> +		.read = adf4382_read, \
> +		.write = adf4382_write, \
> +		.private = _ident, \
> +		.shared = _shared, \
> +}

For two entries?  Macro is just making it harder to read so put the
struct initializer inline without the macro.

> +
> +static const struct iio_chan_spec_ext_info adf4382_ext_info[] = {
> +	/*
> +	 * Usually we use IIO_CHAN_INFO_FREQUENCY, but there are
> +	 * values > 2^32 in order to support the entire frequency range
> +	 * in Hz.
> +	 */
> +	_ADF4382_EXT_INFO("frequency", IIO_SHARED_BY_TYPE, ADF4382_FREQ),
We have IIO_VAL_INT64 for that. It's a bit fiddly but should work here.

> +	_ADF4382_EXT_INFO("en_auto_align", IIO_SHARED_BY_TYPE, ADF4382_EN_AUTO_ALIGN),

What is this?  Needs documentation in Documentation/ABI/testing/sysfs-bus-iio-adf4382

> +	{ },
{ }

> +};
> +
> +static int adf4382_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,

Where they fit under 80 chars, good to combine parameters on fewer
lines.  Check for other cases where this is easy to do.
It is fine to group things different, but here there is no obvious
benefit in doing one per line.

> +			    long mask)

> +
> +static int adf4382_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct adf4382_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return adf4382_set_out_power(st, chan->channel, val);
> +	case IIO_CHAN_INFO_ENABLE:
> +		return adf4382_set_en_chan(st, chan->channel, val);
> +	case IIO_CHAN_INFO_PHASE:
> +		st->phase = val;
> +
> +		if (val < 0)
> +			ret = adf4382_set_phase_pol(st, true);
> +		else
> +			ret = adf4382_set_phase_pol(st, false);

		ret = adf4382_set_phase_pol(st, val < 0);

> +		if (ret)
> +			return ret;
> +
> +		return adf4382_set_phase_adjust(st, abs(val));
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +#ifdef CONFIG_DEBUG_FS

...

> +static int adf4382_show_coarse_current(void *arg, u64 *val)
> +{
> +	struct iio_dev *indio_dev = arg;
> +	struct adf4382_state *st = iio_priv(indio_dev);
> +	u8 coarse_current = 0;
> +	unsigned int tmp;
> +	u16 del_cnt = 0;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, 0x64, &tmp);
> +	if (ret)
> +		return ret;
> +	del_cnt |= FIELD_PREP(ADF4382_DEL_CNT_LSB_MSK, tmp);
> +
> +	ret = regmap_read(st->regmap, 0x65, &tmp);
> +	if (ret)
> +		return ret;
> +	del_cnt |= FIELD_PREP(ADF4382_DEL_CNT_MSB_MSK, tmp);

How about a bulk read, endian getter and then mask? Should end up shorter
code with same result and no odd PREP.
See if similar works in other cases.

> +
> +	coarse_current = FIELD_GET(ADF4382_DEL_CNT_COARSE_MSK, del_cnt);
> +
> +	*val = coarse_current;
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(adf4382_coarse_current_fops,
> +			 adf4382_show_coarse_current, NULL, "%llu\n");
> +
> +static void adf4382_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> +
> +	debugfs_create_file_unsafe("del_cnt_raw", 0400, d,
> +				   indio_dev, &adf4382_del_cnt_raw_fops);
> +
> +	debugfs_create_file_unsafe("bleed_pol", 0400, d,
> +				   indio_dev, &adf4382_bleed_pol_fops);
> +
> +	debugfs_create_file_unsafe("fine_current", 0400, d,
> +				   indio_dev, &adf4382_fine_current_fops);
> +
> +	debugfs_create_file_unsafe("coarse_current", 0400, d,
> +				   indio_dev, &adf4382_coarse_current_fops);
> +}
> +#else
As below. I think you can let the compiler work it's magic as
all the debugfs calls should have stubs and the compiler should be able
to tell this code is not used and remove it if so.

> +static void adf4382_debugfs_init(struct iio_dev *indio_dev)
> +{
> +}
> +#endif
> +
> +static int adf4382_parse_device(struct adf4382_state *st)
> +{
> +	u32 tmp;
> +	int ret;
> +	int i;
> +
> +	ret = device_property_read_u64(&st->spi->dev, "adi,power-up-frequency",
Use
struct device *dev = &st->spi->dev;
to simplify all these calls a little.  Do similar in any other function
that does this lots of times.


> +				       &st->freq);
> +	if (ret)
> +		st->freq = ADF4382_RFOUT_DEFAULT;
	For default falbacks a neater way to code them is.
	st->freq = ADF...
	device_property_read_u64()

> +
> +	ret = device_property_read_u32(&st->spi->dev, "adi,bleed-word",
> +				       &tmp);
> +	if (ret)
> +		st->bleed_word = 0;
> +	else
> +		st->bleed_word = (u16)tmp;
If it's a u16, read a u16 then
	st->bleed_word = 0;
	device_property_read_u16(dev, "adi,bleed-word", &st->bleed_word);


> +
> +	ret = device_property_read_u32(&st->spi->dev, "adi,charge-pump-microamp",
> +				       &tmp);
> +	if (ret) {
> +		st->cp_i = ADF4382_CP_I_DEFAULT;

Consider just using the default value that you can pass to find_closest.
Given you specify the list in the dt-binding I'd just not do a closest match.
Easier to match precisely and no binding should use anything else.

> +	} else {
> +		i = find_closest(tmp, adf4382_ci_ua, ARRAY_SIZE(adf4382_ci_ua));
> +		st->cp_i = (u8)i;
> +	}
> +
> +	ret = device_property_read_u32(&st->spi->dev, "adi,output-power-value",
> +				       &tmp);
> +	if (ret)
> +		st->opwr_a = ADF4382_OPOWER_DEFAULT;
I assume this won't change if you clamp it so simpler code is.

	tmp = ADF4382_OPOWER_DEFAUT;
	device_property_read_u32(dev, "adi,output-power-value", &tmp);
	st->opwr_a = clamp_t(u8, tmp, 0, 15);
Or check it and fail if they picked and out of range value.


> +	else
> +		st->opwr_a = clamp_t(u8, tmp, 0, 15);
> +
> +	ret = device_property_read_u32(&st->spi->dev, "adi,ref-divider",
> +				       &tmp);
> +	if (ret || !tmp)
> +		st->ref_div = ADF4382_REF_DIV_DEFAULT;
> +	else
> +		st->ref_div = (u8)tmp;
read a u8 if you want an u8 and define the DT binding as such.
However, I raised that I'm not yet convinced this should be in that binding.

> +
> +	st->spi_3wire_en = device_property_read_bool(&st->spi->dev,
> +						     "adi,spi-3wire-enable");
> +	st->ref_doubler_en = device_property_read_bool(&st->spi->dev,
> +						       "adi,ref-doubler-enable");
> +	st->cmos_3v3 = device_property_read_bool(&st->spi->dev, "adi,cmos-3v3");
> +
> +	st->clkin = devm_clk_get_enabled(&st->spi->dev, "ref_clk");
> +
> +	return PTR_ERR_OR_ZERO(st->clkin);
> +}

> +
> +static int adf4382_init(struct adf4382_state *st)
> +{
> +	int ret;
> +	bool en = true;
> +
> +	ret = regmap_write(st->regmap, 0x00, ADF4382_RESET_CMD);
> +	if (ret)
> +		return ret;
> +
> +	if (st->spi->mode & SPI_3WIRE || st->spi_3wire_en)
> +		en = false;
> +
> +	ret = regmap_write(st->regmap, 0x00,
> +			   FIELD_PREP(ADF4382_SDO_ACT_MSK, en) |
Field names should provide an indication of which register they are in.
Here, given they registers aren't named, perhaps
	ADF4382_REG0000_SDO_ACT_MSK etc

> +			   FIELD_PREP(ADF4382_SDO_ACT_R_MSK, en));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, 0x3D,
> +			   FIELD_PREP(ADF4382_CMOS_OV_MSK, st->cmos_3v3));
> +	if (ret)
> +		return ret;
> +
> +	ret = adf4382_scratchpad_check(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, 0x20,
> +			   ADF4382_EN_AUTOCAL_MSK |
> +			   FIELD_PREP(ADF4382_EN_RDBLR_MSK, st->ref_doubler_en) |
> +			   FIELD_PREP(ADF4382_R_DIV_MSK, st->ref_div));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, 0x1f, st->cp_i);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_multi_reg_write(st->regmap, adf4382_reg_default,
> +				     ARRAY_SIZE(adf4382_reg_default));
> +	if (ret)
> +		return ret;
> +
> +	st->ref_freq_hz = clk_get_rate(st->clkin);
> +
> +	ret = adf4382_set_out_power(st, 0, st->opwr_a);
> +	if (ret)
> +		return ret;
> +
> +	ret = adf4382_set_out_power(st, 1, st->opwr_a);
> +	if (ret)
> +		return ret;
> +
> +	return _adf4382_set_freq(st);
> +}
> +
> +static int adf4382_freq_change(struct notifier_block *nb, unsigned long action,
> +			       void *data)
> +{
> +	struct adf4382_state *st = container_of(nb, struct adf4382_state, nb);
> +	int ret;
> +
> +	if (action == POST_RATE_CHANGE) {
		guard(mutex)(&st->lock);
		return notifier_from_errno(adf4382_init(st));

and include cleanup.h

> +		mutex_lock(&st->lock);
> +		ret = notifier_from_errno(adf4382_init(st));
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
> +
> +	return NOTIFY_OK;
> +}

> +static unsigned long adf4382_clock_recalc_rate(struct clk_hw *hw,
> +					       unsigned long parent_rate)
> +{
> +	struct adf4382_state *st = to_adf4382_state(hw);
> +	u64 freq = 0;
> +	unsigned long rate;
> +
> +	adf4382_get_freq(st, &freq);
Check for errors.  If you get one perhaps print a message as not
much else you can do in this callback
> +	rate = DIV_ROUND_CLOSEST_ULL(freq, ADF4382_CLK_SCALE);
> +
> +	return rate;

return DIV_ROUND...

> +}
> +
> +static int adf4382_clock_enable(struct clk_hw *hw)
> +{
> +	struct adf4382_state *st = to_adf4382_state(hw);
> +
> +	return regmap_update_bits(st->regmap, 0x2B,
> +				  ADF4382_PD_CLKOUT1_MSK | ADF4382_PD_CLKOUT2_MSK,
> +				  0x00);
regmap_clear_bits
> +}
> +
> +static void adf4382_clock_disable(struct clk_hw *hw)
> +{
> +	struct adf4382_state *st = to_adf4382_state(hw);
> +
> +	regmap_update_bits(st->regmap, 0x2B,
> +			   ADF4382_PD_CLKOUT1_MSK | ADF4382_PD_CLKOUT2_MSK,
> +			   0xff);
regmap_set_bits
> +}
> +
> +static long adf4382_clock_round_rate(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long *parent_rate)
> +{
> +	struct adf4382_state *st = to_adf4382_state(hw);
> +	u64 freq = rate * ADF4382_CLK_SCALE;
> +	u8 div_rate;
> +	u64 tmp;
> +
> +	for (div_rate = 0; div_rate <= st->clkout_div_reg_val_max; div_rate++) {
> +		tmp = (1 << div_rate) * freq;
> +		if (tmp >= st->vco_min)
> +			break;
> +	}
> +	div_rate = clamp_t(u8, div_rate, 0U, st->clkout_div_reg_val_max);
> +	freq = clamp_t(u64, tmp, st->vco_min, st->vco_max);
> +	freq = div_u64(freq, 1 << div_rate);
> +
> +	rate = DIV_ROUND_CLOSEST_ULL(freq, ADF4382_CLK_SCALE);
> +	return rate;

	return DIV_ROUND_CLOSEST_ULL();

> +}

> +static int adf4382_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	struct adf4382_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_spi(spi, &adf4382_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	st = iio_priv(indio_dev);
> +
> +	indio_dev->info = &adf4382_info;
> +	indio_dev->name = "adf4382";
Do that via chip_info as suggested below.

> +
> +	st->regmap = regmap;
> +	st->spi = spi;
> +	st->phase = 0;
st is allocated with kzalloc so no need to set a default to 0 unless
it's a non obvious default.  Here I think it's fine.
> +
> +	st->vco_max = ADF4382_VCO_FREQ_MAX;
> +	st->vco_min = ADF4382_VCO_FREQ_MIN;
> +	st->clkout_div_reg_val_max = ADF4382_CLKOUT_DIV_REG_VAL_MAX;
> +	if (spi_get_device_id(spi)->driver_data == ADF4382A) {

As below, use a structure not an enum.

> +		indio_dev->name = "adf4382a";
> +		st->vco_max = ADF4382A_VCO_FREQ_MAX;
> +		st->vco_min = ADF4382A_VCO_FREQ_MIN;
> +		st->clkout_div_reg_val_max = ADF4382A_CLKOUT_DIV_REG_VAL_MAX;
All this stuff should be data in that structure and you should have
a pointer to store it in somewhere in st.
st->chip_info = spi_device_get_match_data(spi);
No need to check for errors but you can if you like.

> +	}
> +
> +	mutex_init(&st->lock);
	ret = devm_mutex_init(&st->lock)
	if (ret)
		return ret;

Only makes a difference when some debug features are turned on, but it's
cheap to do so preferred in new code.

> +
> +	ret = adf4382_parse_device(st);
> +	if (ret)
> +		return ret;
> +
> +	st->nb.notifier_call = adf4382_freq_change;
> +	ret = clk_notifier_register(st->clkin, &st->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, adf4382_clk_notifier_unreg, st);
> +	if (ret)
> +		return ret;
> +
> +	ret = adf4382_init(st);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "adf4382 init failed\n");
> +
> +	ret = adf4382_setup_clk(st);
> +	if (ret)
> +		return ret;
> +
> +	if (!st->clkout) {

If you have set clkout, does it actually make sense to register the
iio device with no channels?  What is that bringing us?

> +		indio_dev->channels = adf4382_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(adf4382_channels);
> +	}
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_FS))
I think you can skip the ifdef magic above as the compiler should be
able to remove those functions as unused.  Check builds with and without
that protection and see if the module size changes.

> +		adf4382_debugfs_init(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id adf4382_id[] = {
> +	{ "adf4382", ADF4382 },
> +	{ "adf4382a", ADF4382A },
Don't use an enum for these, use a point to a static const structure that
provides the chip specific information as data (rather than code as above).

That ends up both being a more sustainable solution and allows you to use
the more robust data accessor spi_get_device_match_data()
Note though that you should add the same data to the of_device_id table.


> +	{},
As below.

> +};
> +MODULE_DEVICE_TABLE(spi, adf4382_id);
> +
> +static const struct of_device_id adf4382_of_match[] = {
> +	{ .compatible = "adi,adf4382" },
> +	{ .compatible = "adi,adf4382a" },
> +	{},
No comma on terminated entrees. Also I'm trying to standardize
spacing on these in IIO to 
	{ }

It's an arbitrary choice, but that's the one I'm going for.

Jonathan

> +};
> +MODULE_DEVICE_TABLE(of, adf4382_of_match);

