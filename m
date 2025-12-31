Return-Path: <linux-iio+bounces-27439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C6CEC536
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB3F300A37C
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363729ACD7;
	Wed, 31 Dec 2025 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcwxnt9V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D129AAFD
	for <linux-iio@vger.kernel.org>; Wed, 31 Dec 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200937; cv=none; b=G9crTV8tD5pu61pFAG50ajkRu6OQSNzY1zyMvwI19RS9fMoUzqAjZyfJAenOoNlXSWk3tBGy4+UcBpxvTxG9DA9mQLbA+iURmCrqwi3afNKtdSfs+SkjQ6l+SVZaCRVpUfPnYKMJYOHpFHGcOt7RQKhPVFco7dIO3cDUQzsZmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200937; c=relaxed/simple;
	bh=BsQz3MgfzIvdHcOQ6K/Pt8YSviTToGi3Fd9JxKBH/WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXESzaGs0iO68iS7du3uqrW1ZxPpZOYA+glGPuaWkE1TgCSEyDU8vxGKkUL/+DA+vtEs4KV4ftNNk4Owf+sP0hyDcPRTl+4qWnKNA8XWi08W7KxkwWQf0FzHfhGyKAAAD3U4w8RiVT3s7yinTtYNlh/rGvRPeMObDI+bRNRBvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcwxnt9V; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a07fac8aa1so118244285ad.1
        for <linux-iio@vger.kernel.org>; Wed, 31 Dec 2025 09:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767200935; x=1767805735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ahGMNeZOyisjMBf2xg7F5yAgYnagRca+XxEpIk6VaA=;
        b=dcwxnt9VdHYAey+XMdZRgQbmU+hL4nxgquHOLlVpp+++Nv1inGgHUBOg//kL95zrnN
         lX1GkEEYtkVsgqdIQzdeklIR1zedc5eHgPHApRw+q+c9+vQBxjFftj/hUQomksVX6n7u
         7F5X96cwZv5GupymievlCVh1EsTA3vjLq18bYll8CJJXNmJrAiPNKmesPcIqpZ5Qj8NU
         k/yG11nGgYJy8TLTX/seyAmraFuY0fmcrXbY1GjCRD6CgiPKIGZMhZ0d41yPjE44GLwe
         B/9TVKPE/2819K4kcXENylVizpfvhW7oCtfl8Tt2tHu2geW1Ar1ItcCUQz00utlNK8d1
         TDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767200935; x=1767805735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ahGMNeZOyisjMBf2xg7F5yAgYnagRca+XxEpIk6VaA=;
        b=lgsAKkK8RueOLmBJKMHqvqulBpw5EoPEOAosQDiYgiVc60qNCMo5ebr46SPKb0r/xK
         1rd3MvVB544jaFE66xatFZGJg08kHLIP5HKXFrqoTtXxW8NqfQfjUs5XNyr6tWhv03Kg
         8jQFQcD7EM6l3fciD9w6xbkEDzFrry4ATMZTEi0ut5Ntr8EBLqSg/4yn8OXC/fmSBygx
         4/YfY4WmJZ/VSjiDVzqux4V8f6JqkZqx2hHNBBNab8GvExC5VsxUPU1R99llMtpBYxSd
         hF/WoIeKQZx1JsY+MQ1p5qiVxSVsse8GlNO3gHYsS5/G3stbxmy0p4nkqQxgOIGGUJTZ
         EtMA==
X-Forwarded-Encrypted: i=1; AJvYcCVrbdLTuBvwdWXpVeRePGogA62FTC37FNQicMRnsW8K9nrmNKCWUacpqSAClRSefxuPC5VrMltG6aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdyToiCs9SmGgaf0wmkB9WvRCib0hrEov/74QoOQfiVMQhsnN
	DiS8vBTfu/ZJC7Ia9jnjuENUYE4gElaLIPZq5JtipTpSUZocZbBVRGyR
X-Gm-Gg: AY/fxX6tcEyf5SCDAuHz2VgA3LXtz9z66I3OyDGMopguQuNxzOqgCNM5Di59F2kyJ9S
	O4J8s9oJeKR7uo34gjBgDukSRv3W1dYfAaPAwObpxnh4j954NwKOeYWpVC5oqnpas3O9hSDAFZu
	GJNz7SQ8nkLlKpKE8ACnR/zxSADGB0QqyD7rkNjl9w9X5RRziIvsApy/NKqZKRWWP66ocGKfMh4
	ILCTk9E7sDDk0mS/PHdMWSmgGvA2wCF1Sg7qbFfqoYbnrBCbP6GwhK2PETZjHs8YKBIzXBHSFTF
	PL4udJaarBGQ5OPDenbSaaGAtlehjZ6Ec8dVao84rt84i9xDx3QmtxiBnHUHrX7QbkK3dUuimxO
	8Nirvb7fG/ZwxKvlDn0dlSjy0RU7g8l6QRduE6CPJA4V6iT5y1M4igWokm/7uCjyXanyrrzDw5x
	QMTePD6n6y0Ig+um57Xf9AekU3NH3qPcEGEmexjOrxjjxIAwVoH8blwcxkNQadXm1p44EmrZSet
	YFQdwFYxHZa3xNkJ7CDwODADGkkmnIQh7jj74TnHAgy87/7r4n/UL0x8aRuR+zGvlj5
X-Google-Smtp-Source: AGHT+IHyM1m/eNs/WsDhpNstiIr/fvkPWgCZFvgD7JGCj8eGaxWhM5s/oBs0L8ecNW9loSMmMxpcgQ==
X-Received: by 2002:a05:7022:6887:b0:11b:ca88:c50f with SMTP id a92af1059eb24-121722e9d56mr38018389c88.40.1767200935449;
        Wed, 31 Dec 2025 09:08:55 -0800 (PST)
Received: from localhost ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de25dsm104504956c88.7.2025.12.31.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:08:54 -0800 (PST)
Date: Wed, 31 Dec 2025 14:08:52 -0300
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 5/6] staging: iio: ad9832: convert to iio channels and
 ext_info attrs
Message-ID: <kyjemsha276njt5h57xtpev2sgxpxxlk3msax7kbkof2vkg6nz@3whszjxmbil2>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
 <20251230203459.28935-6-tomasborquez13@gmail.com>
 <CAHp75Vch9ud6fP=jg0tFx4WjHKYyfZjwaELBzfSubBVksQ7hSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vch9ud6fP=jg0tFx4WjHKYyfZjwaELBzfSubBVksQ7hSQ@mail.gmail.com>

On Wed, Dec 31, 2025 at 12:55:50AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 30, 2025 at 10:35 PM Tomas Borquez <tomasborquez13@gmail.com> wrote:
> >
> > Convert ad9832 from sysfs attributes to standard channel interface
> > using a single IIO_ALTCURRENT channel with ext_info attributes, as this
> > device is a current source DAC with one output.

...

> > -static int ad9832_write_frequency(struct ad9832_state *st,
> > -                                 unsigned int addr, unsigned long fout)
> > +static ssize_t ad9832_write_frequency(struct iio_dev *indio_dev,
> > +                                     uintptr_t private,
> 
> Torvalds said that uintptr_t shouldn't be used in the Linux kernel,
> the unsigned long suffice and enough. Why do we need it here?

Copied it from the definition of iio_chan_spec_ext_info:

struct iio_chan_spec_ext_info {
	const char *name;
	enum iio_shared_by shared;
	ssize_t (*read)(struct iio_dev *, uintptr_t private,
			struct iio_chan_spec const *, char *buf);
	ssize_t (*write)(struct iio_dev *, uintptr_t private,
			 struct iio_chan_spec const *, const char *buf,
			 size_t len);
	uintptr_t private;
};

But can change it

> 
> > +static IIO_DEVICE_ATTR(out_altcurrent0_frequency_symbol, 0644,
> > +                      ad9832_show, ad9832_store, AD9832_FREQ_SYM);
> > +static IIO_DEVICE_ATTR(out_altcurrent0_phase_symbol, 0644,
> > +                      ad9832_show, ad9832_store, AD9832_PHASE_SYM);
> > +static IIO_DEVICE_ATTR(out_altcurrent0_enable, 0644,
> > +                      ad9832_show, ad9832_store, AD9832_OUTPUT_EN);
> 
> Why not IIO_DEVICE_ATTR_RW()?

Not any good reason just didn't know it existed.

> ...
> 
> > +       &iio_dev_attr_out_altcurrent0_frequency_symbol.dev_attr.attr,
> > +       &iio_dev_attr_out_altcurrent0_phase_symbol.dev_attr.attr,
> > +       &iio_dev_attr_out_altcurrent0_enable.dev_attr.attr,
> > +       &iio_dev_attr_out_altcurrent0_pincontrol_en.dev_attr.attr,
> >         NULL,
> 
> At some point we may also drop the comma in the terminator entry.

Will remove it as part of V3

> -- 
> With Best Regards,
> Andy Shevchenko

