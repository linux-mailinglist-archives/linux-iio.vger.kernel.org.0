Return-Path: <linux-iio+bounces-19793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA925AC0BEF
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 14:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFFE500D59
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ED228BA83;
	Thu, 22 May 2025 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gldOz9op"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C928A72E
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918141; cv=none; b=EJzs1HG2ooWR00dH6Db1vNk6xs4kUHgi4G0ZqJ8r/b5mNpkW0cP8U8ZutxFcjI0KwrihZlv9fZnKyDfsIJvJvxGEBqzXRz/mLQX4hgaV/WoGNkFgoDE8Zpxq7cUzZnepoaNE00l86ijZz4WPVdfEmaAEqGuN1qS6QdS1EO0O+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918141; c=relaxed/simple;
	bh=+sOgwvsatgoXqEWnTWEoK+wqY6J5WR6rnVFfwBiNzm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5t8GN1JzUxFB2Dte8//lda1dOkYxB/Gagk52mnvjhlG8tL2mEa80wZNCeNuTIKwQ9+HBZGFIuGX/lwsEaacULXOUyWeTrdfBKPhgEAiChIlGbP08RALG72EuxUoD1tUd/jDOE2GrVVM0gh+pB3QPJyvSH/mmW5UEqzuLOXavsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gldOz9op; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-443a787bd14so42105915e9.1
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747918138; x=1748522938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PQIZi4PiKgy3h8l3aBRGvp5efW4SvnzfR9lcBVtAa4=;
        b=gldOz9opknqf5IqKRO6+QXvhDmPhDFl9ToLFGE09oGiQhf8mO2n6eMITjc7UqjcXbb
         PnqdDzFEpTWbUqBz0QVOQeGOE8h6VGOQZcZYwMPDoi3GuuFcZPiJOS0NgR8a30pwui+G
         XZ/zyzKNAWz9mflj4O/moaA3/H7X7JLuY/vTk3r3nSm8gcPdhARWbIWZqGn0apilelTo
         m+MQ23jYRDs7YR9p9WgsfLN8e/E/U45FOi1P8BoE4UN8xl1p/uN8RMMbqNaYunFvv6ie
         Z5EA1jJ4z9LcG5HBQQ86JyBUeXV3x8Ty9vQPiHIAxiOhSLhXvWqeFypuBDdVbYEHD4AY
         mgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747918138; x=1748522938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PQIZi4PiKgy3h8l3aBRGvp5efW4SvnzfR9lcBVtAa4=;
        b=G/VMDDt4BM9jgmzu0mnJaITGNYvfIq0DiMr0kym+Cb5zNbMKZFmU6kuOJcLkKIttLz
         hApSxJbkwfWKg3oUhMdacS4c//XBLbfA/4FFxM8kJ9AJUqUFxCwkSNA5nZfijLDHt4ly
         O2n3QRDZH9vU2m/d7VxIxN3scyWtE09SSRuzWCtWyGzC8prN6bsGAb9YmZ0K1rEiWCAf
         WqdJZ7QrzgzDxvptAQkGjm+GyUq8fnh/v3HCAQwqG//bg75gQ1455z8d+HGgZd20SpKd
         OjFcXYIt1ZAQ6lbnR9+qnysvMokg0MJ/vetmNEWUV5wwZTZcqqCBY11Xokh0a8l9ps9G
         RiUA==
X-Forwarded-Encrypted: i=1; AJvYcCUY7OBZwUg8csnEtbPZ+p7eK9KKrf0qe0NFLyqaOpvbOhq3aRECYexpwGq1wJ70y8UsHrAJ13zmzdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyr/gSSJs2YCjDRLJhyGlfNfI8gCq2t5yanoplcaRR6sS4g2Pg
	AbVNdP/U0MgCH1C65b9g3FBsMO3ieZnXycBX3egM80lASywhzvqCAWuInQUL27HMQaU=
X-Gm-Gg: ASbGnctGpai93jhN3SdWqurP1QQTP8liCeZFcd87Lbi/AwAjCjvYDjIEJ+zHjqTH5oH
	CnUsifIJmiFWN51sjm+tKc5GhOaINhc9iFuvptMfpIqMMIWtUzARZzPoRJs8WyiNDxwD5L5eIws
	mVE1bJXLuzijtMHWHylmQwZGaQXzVk/WqndMWv+1naie3GiJkNEhoQq0rwhVMGJcGYK4L7irlxz
	ooAy0n5RL8ZMcs/ZX4W7+QvDk9SZY5pKGfvyu7+zqanX8HxIr00JWEwHKP0njt8zFMo521bS2A3
	X+n972QI3hi7ve5QPiCHl/683RfyJoKDeUeNe8HOPzodt8V7pr5lLjmaZp4yWFbMymO8PuLwfV5
	IzH+OETQW+SkObXKCxwwYSTSaiA==
X-Google-Smtp-Source: AGHT+IGwOMBtRoR9wZDDhiLbv0hq7Tr2RTlAi7lWQeJAGufW+olLnnQ2bNPFnFVvuby1Hp4QfTgrBA==
X-Received: by 2002:a05:600c:3d07:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-442fd93d54emr238025925e9.6.1747918137812;
        Thu, 22 May 2025 05:48:57 -0700 (PDT)
Received: from archlinux (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7ca2de7sm102494745e9.35.2025.05.22.05.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 05:48:57 -0700 (PDT)
Date: Thu, 22 May 2025 14:47:41 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: adc: ad7606: add gain calibration support
Message-ID: <r2tlw3yhjjqwytyswv7onglo7rvedyyireofyiqkwxiosrbiyl@tlk6ijhbr3cp>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-5-91a3f2837e6b@baylibre.com>
 <aBz_Nlgx18UK2GIc@smile.fi.intel.com>
 <shzx67wrpzaxje4vj6owwnof3pi5cuipdavd3k5svucyt5y527@mvytnov6zunk>
 <aCsEeQQyGdBg2ex9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCsEeQQyGdBg2ex9@smile.fi.intel.com>

Hi Andy,

On 19.05.2025 13:14, Andy Shevchenko wrote:
> On Mon, May 19, 2025 at 11:40:09AM +0200, Angelo Dureghello wrote:
> > On 08.05.2025 22:00, Andy Shevchenko wrote:
> > > On Thu, May 08, 2025 at 12:06:09PM +0200, Angelo Dureghello wrote:
> 
> ...
> 
> > > > +	device_for_each_child_node_scoped(dev, child) {
> > > > +		u32 reg, r_gain;
> > > > +
> > > > +		ret = fwnode_property_read_u32(child, "reg", &reg);
> > > > +		if (ret)
> > > > +			continue;
> > > 
> > > > +		/* Chan reg is a 1-based index. */
> > > > +		if (reg < 1 || reg > num_channels) {
> > > > +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
> > > > +			continue;
> > > > +		}
> > > 
> > > But this will allow to have a broken DT. This check basically diminishes the
> > > effort of the DT schema validation. If there are limits one still would be able
> > > to create a DT that passes the driver but doesn't pass the validation.
> > 
> > fixed all your points on other patches of this patch-set. Still your
> > emails are going to google spam, just could catch them on friday. 
> > Really not clear why.
> 
> DKIM which I still need to configure...
> 
> > About the above, i understand, but the check is actually the same as
> > in ad7606_get_chan_config(), a warning that fdt is not correct, 
> > i dont see a blocking issue here now, so not going to change it
> > in this next patchset.
> 
> I think the 'continue' above is simply wrong. We should not allow to have
> broken tables. And I think it's kinda blocking issue.
>

Actually the driver is informing of an incorrect channel node and passes
to the next channel, instead of a probe-fail. It is not introducing any 
non-functionality, just skipping that channel.

Not a big issue for me to fix it and issue a v6. 

If it's really wrong and needed, then i should fix this same issue that
is there in other previously accepted parts.
 
> > > > +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> > > > +					       &r_gain);
> > > > +		if (ret)
> > > > +			/* Keep the default register value. */
> > > > +			continue;
> > > > +
> > > > +		if (r_gain > AD7606_CALIB_GAIN_MAX) {
> > > > +			dev_warn(dev, "wrong gain calibration value");
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> > > > +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> > > > +		if (ret) {
> > > > +			dev_warn(dev, "error writing r_gain");
> > > > +			continue;
> > > > +		}
> > > > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Regards,
angelo

