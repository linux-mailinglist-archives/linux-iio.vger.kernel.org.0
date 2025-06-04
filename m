Return-Path: <linux-iio+bounces-20196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92760ACD515
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 03:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A727E1BA1888
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3241A08BC;
	Wed,  4 Jun 2025 01:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjW4hety"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFE1B0F31
	for <linux-iio@vger.kernel.org>; Wed,  4 Jun 2025 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000710; cv=none; b=ROf4YxgWpJAmbfzIY0PkDakFKgL1WRrgwz3aM9NS0vcHB5d2QCPGJaH8tMFQQp5WIJPZtUMWR4GRtjLYrGhr8v+s5VOGm6jj+xG7Qxa6qtVVXtCI1xiWG0aop1tgsl2RDwPDC6iLE5KDnOyqOL01RxIGVne6n93vpBTjQNQWPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000710; c=relaxed/simple;
	bh=RznLwf2CJ+WlCaNyLIQ141n6mCWxYOhQFkAPcAtScJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCFCZqkjB/cqqCFgcpKEeNAKrHI/J4A/yzuWeADSy7Uhb31IV9LTZf+KVSSuM5CE34cEqdc8lkI2Ty8h6gJs+JhTk0jhxApJOML7J3jSxqVw5c0E4gvDlBrL19vshbhKWdpVzflCqqajvZsD6wV4ZtK1AwEwUMOMKm5J5j90CWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjW4hety; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e59af1f0e7so1919586137.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 18:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749000707; x=1749605507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMHZmnOL+kE0lZ/LmQ9of9e7ItrMPRPvKAT6Hp/HI18=;
        b=VjW4hetyd5Zarp7NZhKKtgLNz074aIaZzDc+9Z84zVXb2m6unwfm+IvISmO+XAtmWs
         /wpYyTojHX8lDkfVzPrUOc0m8pws3V+SR8pAGiqL9hUScIav6iX5fL9O4YcY3dVhcUh8
         lAGDqKJszfNAa3C+TQNiG/Y5JyxhNF+0krK50ox3qh+5su/MYXcYMlA7ebOr6zLwomtr
         enZF/kd4s0MDewJtl/jR9aiFO2jqYRpYj0TmComJv99eqAOJvIpdXENfQGfdZ+JaMXgN
         WLFB4N88lSlBE1A6vyJXtYj9CmPbHbIAJOa0FzAddpY35k3lnFY873EovZyGeJrfjpj0
         nDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749000707; x=1749605507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMHZmnOL+kE0lZ/LmQ9of9e7ItrMPRPvKAT6Hp/HI18=;
        b=cb6LcPWXA14+huCgA5oM9iP2NuKtAnmoyRG7NmCUDGEWuCYg36fDIexcu4Q/ePEG7Z
         QPJXaaxD8+iZDs0cQPonDqawLv6bpLYCNiG9orfeNPheV7nh8AeD13uRVhP8oUdWCw2k
         oyP+8O08TdsZC+dlsRmSF9aeviVvH2+7Q9qmKhtWx7tEVxa3SovzN9YkN0QegHA3bkKV
         1WJPxwF23k7v+hLn+XaqDByeWpdwxZqi+E34tDVhb1Nm3rlLOVrwcguSMLXQOcKh7kOO
         nnibtjFEDia4wCyvOL90uASriWyj67ijSmGkqwFISBwQDYW4Vw9FKNYWWwid4vSOpj8e
         UzMg==
X-Forwarded-Encrypted: i=1; AJvYcCXBi7b6DACKB6ipMtkKAD5Gvxy+JM2kDsZeZr4g1AgX2AxomyMffdr9S/EoqzBHZ7m2Y/FGwlVGxnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBIKfsg6P5hMUgBpJeVySj+DChzVkbITNWgutfkh9FMkX7gNr
	eUgvfRzxC+VFsi0NfY56teDhRUyeN5Pp+Q18wEdJgmhF+0lCi028o9PB
X-Gm-Gg: ASbGncv5IBTmKI3lFsD/eYDAkO1l4zhiCT3KvQ2JZS7AAbS8RpM5MoxR/yWaF6A9W8Y
	KWpMcx9dCyjFCbB+i6YSKTDXM8zHIVPztIB7NI7Eyt3U2owQuDfIGwT4zM/8AEZZzuqRNhAgvBT
	KS2Nk9LRsUakm2nhRZdtxI8SW//EtoFXjpd59+LaFzRZO+C1d/0iHtI3IiZ1zwfaU3frIQjwIeB
	KxTRSsOS3KIFqfekw89UNln7XMkiUevwjRwMfy9T4CKImGgOtVDDecL+74tWpCW7aDAPlMdyJR+
	/+PFPABrFv3w+LyjUIsGQTD4x2nDFQsHjM+dMgW+CuZvZ+wg45UNpusUruNBy1dAfJoHJ/w5KBw
	agGmq
X-Google-Smtp-Source: AGHT+IEqDouQH2TnvtgW3+nJGQqszVrEeEFyiQT+hOf5L/ujsQfEyITjPGbdx1r2lAOhmEXo2/FajA==
X-Received: by 2002:a05:6102:d94:b0:4e2:a235:2483 with SMTP id ada2fe7eead31-4e746e08230mr554991137.19.1749000707190;
        Tue, 03 Jun 2025 18:31:47 -0700 (PDT)
Received: from localhost ([2804:30c:406b:9100:2a26:16f5:c81:e61f])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-4e64e9f28a2sm9520045137.26.2025.06.03.18.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 18:31:46 -0700 (PDT)
Date: Tue, 3 Jun 2025 22:33:23 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: nattan <nattanferreira58@gmail.com>
Cc: subhajit.ghosh@tweaklogic.com, jic23@kernel.org,
	Lucas Antonio <lucasantonio.santos@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: apds9306: Refactor threshold get/set
 functions to use helper
Message-ID: <aD-iY4aUWTcv1etN@debian-BULLSEYE-live-builder-AMD64>
References: <20250526235906.6598-1-nattanferreira58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526235906.6598-1-nattanferreira58@gmail.com>

Hello Nattan, Lucas,

This version looks good to me.
One minor thing below.

On 05/26, nattan wrote:
> From: Nattan Ferreira <nattanferreira58@gmail.com>
> 
> Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set
> functions to use a helper function (apds9306_get_thresh_reg) for obtaining the
nitpicking: commit message and description are wrapped to 75 columns.

> correct register based on the direction of the event. This improves code
> readability and maintains consistency
I think part of the description from the line below could also fit into the line above.
> in accessing threshold registers.
> 
> Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
> Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
> Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
> ---
Friendly reminder to add a change log below the --- if you send a v4 (or v5?).

>  drivers/iio/light/apds9306.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 

Regards,
Marcelo

