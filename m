Return-Path: <linux-iio+bounces-16865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335DAA62ED0
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 16:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320AF3B67F0
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243F2036E2;
	Sat, 15 Mar 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPXwGsKO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF21FC10C;
	Sat, 15 Mar 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050966; cv=none; b=IiMbkCpCn7V5YDPBN77R0YkCZIMGiC2MnUqGb233fcutByGFmT6i8Kv+DlrZx6FwDXYwvi+URLhvTgHGLpfBUOhdH0oU1bKq87YU/X7LBdezljzLAnT9zJ1HcgMf8t75gfh3C7qvNjBz5KG3fuNPbdRAGDtXD59B0atQtRoQT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050966; c=relaxed/simple;
	bh=XqF3IeZzTFF40J3s4HW9OVwOhxZElMbeqnL/RHeXcqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4OLsWhcN/wW2DYGhMVnjTwdvPEoYh/kBSw2WfmIVXwn/dRxl3rR6Fn2za5Kwq+pFfwxEEE0Z1OpvNXPB/0lu35lF1/Yd/aEThouYu1MZYIdYR4Zb2WODR3PodrEL7cWj5TZGBcstxdN/SsvUpBmsHX149qv2324fFBd//XWkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPXwGsKO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso1075642a91.1;
        Sat, 15 Mar 2025 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742050964; x=1742655764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d36rr9lbrju2jUirQ00gDiMRY8Q66JkPVxj4yJNU2u0=;
        b=iPXwGsKOCKuNBEYlClZNyF0+Ry4zwsmkgLbW1ifIUWv+9WnnhGU6UKHyCdCXp5IUV+
         usXeZNrg5yvqXq+NyviS9pIcmp2sRcHGCox9UjtKkPn9OVbq56lGQyUr2ZWwTJn5NlF7
         1bjJ4Tzj3yoVcPE1F8KctF8K13NE/0MlwE/VbmVk/fsP71y80UgvYSBuAKg8WkoXtHN9
         GZJqxOVSFJSJgOrCEZ7OtYVQcKfJSt1BMGIL74VuqVc0ig2tXIm0IhicblfbPsHQpWbe
         YGrm0bdT3tbiRMk04d4VxK21sxPgyb1vm4FN5ZQUUu+UzwBLHKbHlLwZm/fsl7mjbVCZ
         sSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742050964; x=1742655764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d36rr9lbrju2jUirQ00gDiMRY8Q66JkPVxj4yJNU2u0=;
        b=mtZD0I7SygCqEqD/PvgeIg1LAhMHL7rrosxfrUWp3/6sjrb1W5/VoRF638s3VaeAFA
         MhowAChkE8u7w7/YMl5iTrHSs4xbeVt56AUA6Ga9NdZIh4FQGI4Q6LGNQNtY6s6Ugo2r
         jKjyPlpI3BZPrG+lqVkwFy2Zs884h/Mi7jzy/t6WyBeedx90pOWm05SJLvyXiGFaw4Zg
         n5Y67CsjU0dTh0CGRqHL0rMYx0zPVbiEg5mFs9mSxvOOyONaOdi2+b6+5YnxOk/ZaAOv
         a5RoGnDeI200VFvRN3P8Q4GRhNtZgW1k8OP2bTjIiDKnjesq6B2o17Gu/vuLnD1yf6l2
         lBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGmaaSCP3MnfozppIsADY2c0MCNVOzU/jMyzY65AVmsHR3HIKC0YyztzYbjbL4kcttaoXLOUqcTQc/K+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrMQWb5EA9R7VZx6okodw65lhIiwwocjyZ7BbsCf5+R+PAuWq
	MUgdriiMaZiaegbHnLVEETGEPnHlHeQ9g4GARV1AbzG20tSUJFlw1Eq4lYdg
X-Gm-Gg: ASbGncs7PpKSORL9wNeJDEXYnDObohyirDalqfQvb59/3WG9e8HHCl7dMT0LzsV18Vy
	0DTkX3bTxiEGnZRJwxt30A5LuKpugjSqBQ4rZ8tF4ky0IKWe7x3FNOj9YoVLPpwDnf8trGctymB
	C0EM/Cpfb2IC7fLnPMiYSUL2R8P6a4feauHnpOXyp3mWfH6EZkGNzI7NXsy9/vX7aYgcVbphLW9
	r0R6IeV9vROPOpiCwdyS2v0WXiDZ+HYVcuVeS88cyoTzW19buCTeaGQNoXTH6LCJvSjpKt2Ye+9
	1U3suHIODqjxP/5dubwCiA8h+RZUvC1ldasoRAL1ln48BxFCsOcTKA==
X-Google-Smtp-Source: AGHT+IHvcEmAdvz4RKtwFUcK1Fgq2J0xP+4bcNXQJl3RwHxm388HFDW0oxHY+0N5ExqvwKIHv7yTkg==
X-Received: by 2002:a17:90b:2dcc:b0:2ef:31a9:95c6 with SMTP id 98e67ed59e1d1-30151c7a2f4mr9616945a91.14.1742050964191;
        Sat, 15 Mar 2025 08:02:44 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301539d3f4bsm2834921a91.5.2025.03.15.08.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:02:43 -0700 (PDT)
Date: Sat, 15 Mar 2025 12:03:40 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] iio: frequency: ad9832: Use FIELD_PREP macro to set bit
 fields
Message-ID: <Z9WWzMGdBga76zm9@debian-BULLSEYE-live-builder-AMD64>
References: <20250313195442.30264-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313195442.30264-1-simeddon@gmail.com>

Hi Siddharth,

Adding some comments inline. If what Jonathan suggested + what I suggest bellow
is still insufficient to avoid those lots of shifting to make up a write
command, then probably not worth it to change those as Jonathan said.

On 03/14, Siddharth Menon wrote:
> Refactor code to use the FIELD_PREP macro for setting bit fields
> instead of manual bit manipulation.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 39 ++++++++++++++------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..bbde1f0e84ff 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -70,6 +70,9 @@
>  #define AD9832_FREQ_BITS	32
>  #define AD9832_PHASE_BITS	12
>  #define RES_MASK(bits)		((1 << (bits)) - 1)
> +#define DATA_MASK       0xFF
> +#define CMD_MASK        (0xF << CMD_SHIFT)
> +#define ADD_MASK        (0xF << ADD_SHIFT)

We could have masks for each part of the write command. For example,

#define CMD_MASK		GENMASK(15, 12)
#define ADD_MASK		GENMASK(11, 8)
#define DATA_MASK		GENMASK(7, 0)

>  
>  /**
>   * struct ad9832_state - driver instance specific data
> @@ -139,18 +142,18 @@ static int ad9832_write_frequency(struct ad9832_state *st,
>  
>  	regval = ad9832_calc_freqreg(clk_freq, fout);
>  
> -	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
> -					(addr << ADD_SHIFT) |
> -					((regval >> 24) & 0xFF));
> -	st->freq_data[1] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
> -					((addr - 1) << ADD_SHIFT) |
> -					((regval >> 16) & 0xFF));
> -	st->freq_data[2] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
> -					((addr - 2) << ADD_SHIFT) |
> -					((regval >> 8) & 0xFF));
> -	st->freq_data[3] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
> -					((addr - 3) << ADD_SHIFT) |
> -					((regval >> 0) & 0xFF));
> +	st->freq_data[0] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE8BITSW) |
> +					FIELD_PREP(ADD_MASK, addr) |
> +					FIELD_PREP(DATA_MASK, (regval >> 24) & 0xFF));

Then we can use FIELD_PREP() in combination with the masks. Example,

	st->freq_data[0] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE8BITSW) |
			   	       FIELD_PREP(ADD_MASK, addr) |
			   	       FIELD_PREP(DATA_MASK, (regval >> 24));

> +	st->freq_data[1] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE16BITSW) |
> +					FIELD_PREP(ADD_MASK, (addr - 1)) |
> +					FIELD_PREP(DATA_MASK, (regval >> 16) & 0xFF));
> +	st->freq_data[2] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE8BITSW) |
> +					FIELD_PREP(ADD_MASK, (addr - 2)) |
> +					FIELD_PREP(DATA_MASK, (regval >> 8) & 0xFF));
> +	st->freq_data[3] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE16BITSW) |
> +					FIELD_PREP(ADD_MASK, (addr - 3)) |
> +					FIELD_PREP(DATA_MASK, (regval >> 0) & 0xFF));

If able to make regval an array as Jonathan suggested, the above may become
something like

for (i = 0; i < ARRAY_SIZE(st->freq_data); i++)
	st->freq_data[i] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE8BITSW) |
			   	       FIELD_PREP(ADD_MASK, addr) |
			   	       FIELD_PREP(DATA_MASK, (regval[i])));

Note the command alternates between AD9832_CMD_FRE8BITSW and
AD9832_CMD_FRE16BITSW so maybe also put the command constants into an array or
use some ternary operation like i % 2 == 0 ? AD9832_CMD_FRE8BITSW : AD9832_CMD_FRE16BITS.

