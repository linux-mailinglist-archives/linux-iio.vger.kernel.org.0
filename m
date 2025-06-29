Return-Path: <linux-iio+bounces-21133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE2AECF7D
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 20:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB7618959E0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE18221277;
	Sun, 29 Jun 2025 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXesNUMd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FD1624DF;
	Sun, 29 Jun 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751220930; cv=none; b=Fw6Qnmgv3a7u89cuLSQWu284Al74gEavjBAstl5Gmt8IdpMP3sGT19AmDrFz2VgJTx3SZRKFCKB0bqzeSLI/0/eFAqCr4FS+Qr9LbF3hawoBs0gAzgOjhCQThQ/PzC36ybfmHNsggrXTFdwx0h6mhf58p+3P+5VMoAYMBSe9F6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751220930; c=relaxed/simple;
	bh=EIXdipzllbtucUEfHgZ1VdvFVn9XI+aZ2XDRWP0cv20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq4vGQ5SFnY7jbo862ETXWQCCKrQoBBAQhEtTYPhUkUej8CxT8uhmDsIzjxyzlNwzFrAV2euykgEePojhhwY0q+NgkSqvdGjQOkDvFK42jdAmIHiOu5dwUjlw3/9WJiE9TABed3t4um/xbXaCVNjhl2xyD1FrlMQc86UTHpvrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXesNUMd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a8f69862so1317791a12.2;
        Sun, 29 Jun 2025 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751220929; x=1751825729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzE3I5NecvUCU3UQC0+WGIW7kPRRewbwrBU9MK5CI+w=;
        b=CXesNUMdvwp5E749Z4+LxPo+hGll96zbrUqF4hZVqZjQeiSgpA0rbJ1WFBtYbwDhNQ
         yJwpcTmCa5WHUkgVMOcpOwYTPKXy8L/ayxyd1J42NzoXk3v0EgzrzWLgCmTaZZU99Z9z
         M9dyFmj7aHGVheyRU37c3v6xobkHm/8d6CSOThf9OhqYPaSjETg258is4cMa/Xmi/CwJ
         ZBN0cykod2/J+hm++ME+ktRkN6dOFOwH5zddB9MB7SkuCBIui8jq/tvgDK/NaiopsJAx
         W7Lz5huugbqNHumprPUtwB7ohzkuHCaM36WEKexnNwW2+fGYIU469LuVc4fUkekkgYli
         EjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751220929; x=1751825729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzE3I5NecvUCU3UQC0+WGIW7kPRRewbwrBU9MK5CI+w=;
        b=wqSGtFMuWvh7X7QqtwirL+PbOVWAd9ZTOLm8ZSKoUCco/yY3N9YK/oUx2rnADQrN0X
         2zCBsUn2cEVnDIXzMlrag5HZyGYaMgbVVl7ED6tTrleRa42fN5X/fnDnXHiydHMoRT/9
         LnLRu8w5MOTpqBVpdWv+uTUAEOpDKYTUWuGss6rmN52ZmyoQd2b4qVSZ++rt5MnAXZn/
         9V7WMgyr43WXdgeArd+Ct3GPOLewZXCEv+NN8oqI//BG7PPbnUWw38GSV5WbrP/YqrEe
         Uev6Vf+48ect2AJyB/ScTdOQB1Nb5RSBjZoYiV57dOvsZYQzyC42FBfBYT99Gwz9lNO/
         scCA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Nf0mTBbRNzO87HrRSZax9xtXw7ql4PP7b99g1aUbVMFfCHrc5GQg4nYzGNHn+VOXm8fFAsNvKAM=@vger.kernel.org, AJvYcCVSyN5S0OoTiSyA5d5Lk7KQmU1tgXDpFLr2t/wvxwK5Dm76WWK+V9KfIH+IUzv0KoRV0oD2B4BMUkT9xZ+5@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0wgE09sFByckDHkrN8uv6XcxGCNa5rULFhPABq1zhdBs83by
	APpYuOa/7yGHgB622INNrpsIc0hWgPBg5dCRRea0mHeKHzUHHVPWdziyMgV4/Lok
X-Gm-Gg: ASbGnctcKPgzPQ1nH3dx339vyHfPLNq3qgYnn6LGpl8p8IdtGsna85l+9RmcknUrWPw
	U3UowPTdekTD2uUiJJ/iM3MdXXWWRXgIkMvjb8GsVDWxof8+c+nsNfDlu8KMT1Y/BoKZfE+nFPl
	pvHSzcwYmDkwTLtAbbV4mKjq1uMMYpJiYeOXv1s5Rn+jJ66gUZF4myulNt7ZA21nkocV4fThppv
	lNAVAfutc0BcJAyIPmBWpRDLBlEOpQlvTgsXgPNKa8Bh9abImMMxtv7jkXFxePF8n0GScwoD0gs
	NuHXAEcaf1XtzRpKyWJJIz1H7D9RqlmbC9R0yF8loTPOvYJ+HpPPyChdHH2AJgnEaBNRDg==
X-Google-Smtp-Source: AGHT+IFSuHQ5X0rXEbUzIZPYf4LbToWKXowQKJzKkbr1S1nQ0Z+Vd2OeIq3grm+Yk0T5AGZY3grXFw==
X-Received: by 2002:a17:90b:4c04:b0:313:1e9d:404b with SMTP id 98e67ed59e1d1-318c910d85dmr15971097a91.2.1751220928705;
        Sun, 29 Jun 2025 11:15:28 -0700 (PDT)
Received: from localhost ([2804:30c:b15:b200:425a:de22:1d7f:2d4b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f542708esm11782024a91.30.2025.06.29.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 11:15:27 -0700 (PDT)
Date: Sun, 29 Jun 2025 15:17:25 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7091r8: make ad7091r_init_info const
Message-ID: <aGGDNR0b0TTjSRNN@debian-BULLSEYE-live-builder-AMD64>
References: <20250628-iio-const-data-4-v1-1-4e0f93c9cf83@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628-iio-const-data-4-v1-1-4e0f93c9cf83@baylibre.com>

On 06/28, David Lechner wrote:
> Add const qualifier to struct ad7091r_init_info ad7091r*_init_info. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

