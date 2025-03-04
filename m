Return-Path: <linux-iio+bounces-16343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D8A4E00E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FEC3B59A9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13997204C2C;
	Tue,  4 Mar 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw6KPDFa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C11202F90;
	Tue,  4 Mar 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096769; cv=none; b=a60Kwwr8/Fi4YI2uFajAyb+fpyWipBUvSYh+jbPR4HhyhWjbqSeGzS1sl0GztyU2i1MBckZ9Pzzo0owDEjFuZjpGU5zA20mL48rbi4cDDfqNaoAKV9bKBOeaHwfmOzOOTs7fytRk6c1cex7BopRle4NGMUGpKI7IdW16k4Ac/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096769; c=relaxed/simple;
	bh=EQqcHu83LSODXEmE1HAvgCk/Pej/5geFDZJy8+/PWg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7AJKT1J1DEY15nCxlKJKB9XGu5m89sAxRlW1nmnPuDOo71iVULdl1AOaRlcpLj8LnlrQ+j4vgIP/ESHyUSGZAxh31v4NWdlmuKxqsRTCVMhPsCZ3jUvUUlge0+DIc3HXyHHzNkqtaXFA0d73QGPzXJcIqWslWOQOl3PXkFqIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw6KPDFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B505C4CEE5;
	Tue,  4 Mar 2025 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096769;
	bh=EQqcHu83LSODXEmE1HAvgCk/Pej/5geFDZJy8+/PWg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lw6KPDFaOyM5pw7Cq+bPY/pEPmHgxCLFOXjcaBpJBFm1cT2NRZuFCtEwJPDKEIbAg
	 a0Sq8v5+2A0zsw8u7DmuWRowhMT22ybgMVarYyABlr+SuOQLQagljUafPuKY8b4iAi
	 B/FyxFt42KU2gcRuDru8QGrHo3i1naZIOp6jtO77Ph2u/PdpXPGLd6QJTzGcO2MDEn
	 GhAUxWgc/3U2MrZ+W5Uw3Qix/ajqWR3czlwfPH136Z9rCvGgNCzWtYdLS4or9HNRSB
	 5nRE4nolSPRBxm22vM8CPuzXlkiTIB71XxQ6SLFRRPsqXJu+VrOquMKOnEYfaabMOD
	 /2NimGTH/gDSQ==
Date: Tue, 4 Mar 2025 13:59:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 14/15] iio: accel: adxl345: add coupling detection
 for activity/inactivity
Message-ID: <20250304135917.39ef0071@jic23-huawei>
In-Reply-To: <20250220104234.40958-15-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-15-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:33 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add coupling activity/inactivity detection by the AC/DC bit. This is an
> addititional enhancement for the detection of activity states and
> completes the activity / inactivity feature of the ADXL345.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> @@ -337,6 +356,69 @@ static int adxl345_write_act_axis(struct adxl345_state *st,
>  	return 0;
>  }
>  
> +static int adxl345_is_act_inact_ac(struct adxl345_state *st,
> +				   enum adxl345_activity_type type, bool *ac)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
> +	if (ret)
> +		return ret;
> +
> +	if (type == ADXL345_ACTIVITY)
> +		*ac = (FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval) > 0) ? true : false;
> +	else
> +		*ac = (FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval) > 0) ? true : false;
> +
Why the ternaries? 
		*ac = FIELD_GET() > 0;
is a boolean right hand side anyway.

> +	return 0;
> +}
> +
> +static int adxl345_set_act_inact_ac(struct adxl345_state *st,
> +				    enum adxl345_activity_type type, bool ac)
> +{
> +	unsigned int act_inact_ac = ac ? 0xff : 0x00;
> +
> +	/*
> +	 * A setting of 0 selects dc-coupled operation, and a setting of 1
false and true rather than 0 / 1?
> +	 * enables ac-coupled operation. In dc-coupled operation, the current
> +	 * acceleration magnitude is compared directly with
> +	 * ADXL345_REG_THRESH_ACT and ADXL345_REG_THRESH_INACT to determine
> +	 * whether activity or inactivity is detected.
...
>  static int adxl345_is_act_inact_en(struct adxl345_state *st,
>  				   enum adxl345_activity_type type, bool *en)
>  {
> @@ -695,6 +777,11 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
>  	if (ret)
>  		return ret;
>  
> +	/* update inactivity time by ODR */
> +	ret = adxl345_set_inact_time_s(st, 0);
> +	if (ret)
> +		return ret;
> +
>  	return 0;

return adxl345_set_inact_time_s()

>  }
>  
> @@ -718,14 +805,54 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
>  
>  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
>  {
> +	unsigned int act_threshold, inact_threshold;
> +	unsigned int range_old;
> +	unsigned int regval;
>  	int ret;
>  
> +	ret = regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval);
> +	if (ret)
> +		return ret;
> +	range_old = FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> +
> +	ret = regmap_read(st->regmap,
> +			  adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> +			  &act_threshold);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap,
> +			  adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> +			  &inact_threshold);
> +	if (ret)
> +		return ret;
> +
>  	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
>  				 ADXL345_DATA_FORMAT_RANGE,
>  				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
>  	if (ret)
>  		return ret;
>  
> +	act_threshold = act_threshold
> +		* adxl345_range_factor_tbl[range_old]
> +		/ adxl345_range_factor_tbl[range];
> +	act_threshold = min(255, max(1, inact_threshold));
> +
> +	inact_threshold = inact_threshold
> +		* adxl345_range_factor_tbl[range_old]
> +		/ adxl345_range_factor_tbl[range];
> +	inact_threshold = min(255, max(1, inact_threshold));
> +
> +	ret = regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> +			   act_threshold);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> +			   inact_threshold);
> +	if (ret)
> +		return ret;
return regmap_write()
> +
>  	return 0;
>  }


