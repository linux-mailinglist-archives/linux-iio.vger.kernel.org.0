Return-Path: <linux-iio+bounces-22555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B0DB203FB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96B23B12E9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B33223DFF;
	Mon, 11 Aug 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adI8ZUIp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8B21FF3C
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905359; cv=none; b=CisJqAt7h6+MgxMg5xZKuhKerTCMt7b4lpsRK2w82iWini6m3WBXwrRyoQ+XKclRcjoqJ3P8SK07oZhL4NwRI7ZiDrgOErYfHesPEn7hGQFGgVFKjaxBaWKGWDqToU8Dqol7JAub06WZ/ruhPZ7P36wZ36tPWT32gY60zSdKH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905359; c=relaxed/simple;
	bh=Zn/F2aMiaQC3MzWDVgkS0gcr0XHxXSShh+zpcz+4tEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyXHh7PzEvrx1g/tjJ20yHEH7q6ZoWXDs8VLUaf9sZl5bqynEe87vV7bUfcsJSetEd/mFzIg1NM19dkp3sx2gr4g93dga1eB4IF9HVXQvR5fbnBij+JDI0h/Y9B0kHw3IUeviceKyhltWyudw55k3ZtQY1cqyzFOa+p87wo3Z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adI8ZUIp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b90ab438edso870847f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 02:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754905356; x=1755510156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4VmVADIlHANvVAnWwMVkBac9OTIlljTlPRlakDSmP4=;
        b=adI8ZUIpbn5fNOjwqGDAAki5mqJ3+8PGKCyJMfnS7XHSd5M0Y30rNntIqGgQiTMHFI
         y84c/93Z4xIs5U1rI0r19T0UaVZNY0I3rLb2kNoJClG7PcV/GfxgoS0b+S/ZqjP72kWE
         H1nCOQepbEkV2z/2MYp1Tn9HtdaOKURJZ9UV5AOnR/IYUpUrgFJuSkmoEJQNFNdf8242
         J/cIKoZ98ZqDABa69unyOTE64Is4vbJgtSWrl5nMfds9Vn0gJd3OYqyLNO+j0n8npNUD
         3UqBgdOb44NEr30LDH7/x7eXuADu9eDp22dbudDuDlzIrEjhXx7hVtlLI+4Mx6CAXN83
         rwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905356; x=1755510156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4VmVADIlHANvVAnWwMVkBac9OTIlljTlPRlakDSmP4=;
        b=RYhgv0m9kCkDlYq8kZH9D1LucXfNEX4ElnhciLnYf3jqGyPiM9Z9vt2EJR6qpqcwT2
         Yd9lc25fHB4UkbPj3d6zDh5xbl93PMch3LWBmzg6l3/KOPHmi8YB3MnJT05DSIrxdS9G
         EqV9RColTRz/N85/13NLtv6E5EtNATSNMiwbp10jeLcGmVgTlrllOZ/YZeoYnxr7nswQ
         Q5nKFeeKZUTQ3IkyAEPFt/ldGD7W247OvHYZpkvM9o3vAA/kMa/Tg7E2D5NOejeFO+/0
         Oag30eUsGAVQvWuxH+xOg/c7ySMQO4a2nlERLSmujwkX559VLqfIRhqugXGcSrEJgWsC
         Co9w==
X-Forwarded-Encrypted: i=1; AJvYcCWpBb3gewJY++WAYOL7SSRCT+T6o9WVYRGv/Co7zbEZoO40blGuaW31hW5nbWXsSbTTpmpGg9pVt2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqBX2wGI3pzbNs/bzGKzHfs6jXeB0IyLZVhETwRxa8BYJvJvp
	14wfAIC9wSMWC7NbeVchCTeb9++FLy74ETAhZr7ZOPDfG2IaoahsufzG
X-Gm-Gg: ASbGncsem9tvT2RB79z8TyarAlvlu+GHCjEtrqn/rpN5NTCKdKqZJIps8e0YWteGS+E
	7hcvPzO8mSEwBZ/NCJHhSU5vBi27wV0XWvglA5KSSsxehFlD1jkPiHZmLzI1pyIbYVllNuCwc/o
	ZvUTdMltF72CFp2dvwQ1tIYmJUeqA7g7mu6q9hxgxNB+9wQNVvye4obq4fBVlLRzW1hoVIjQxDf
	s1T+bak/Au0HN4eOWdGfyFAVVHsOVGtJshnn3Zr8xsj4mQ8jHBBrXn1+4CqWgIuy92n52ML1XZz
	2WL1pY62KBLuUpc1Ng3esDobV93zCGdZkua2bWTNhCMTVhgBEwTsfDo1LfdBf7w2Q0nGkz1xkL6
	w8UOJVX6+LCzTZR7ZSSds4Wbk
X-Google-Smtp-Source: AGHT+IEWQDJpE0uVr6tuYIqdwM61qFjAdP0gCSaqzadsN0+V1dQVF+ElD+9cFpAhsns0hVlkPgR28Q==
X-Received: by 2002:a05:6000:18a9:b0:3b7:e3c3:fbb6 with SMTP id ffacd0b85a97d-3b900b7b012mr9788492f8f.31.1754905356276;
        Mon, 11 Aug 2025 02:42:36 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b4f9e952sm387221305e9.9.2025.08.11.02.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:42:36 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:42:53 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
Message-ID: <g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
 <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>

On Fri, Aug 08, 2025 at 11:56:23PM +0200, Andy Shevchenko wrote:
> On Fri, Aug 8, 2025 at 6:09 PM Nuno Sá via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >
> > The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/9.
> > When set to 4/5, the maximum RF frequency allowed is 3 GHz.
> > Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/9.
> > In this context not the RF output frequency is meant
> > - it's the VCO frequency.
> >
> > Therefore move the prescaler selection after we derived the VCO frequency
> > from the desired RF output frequency.
> >
> > This BUG may have caused PLL lock instabilities when operating the VCO at
> > the very high range close to 4.4 GHz.
> 
> ...
> 
> > +       st->r4_rf_div_sel = 0;
> > +
> > +       while (freq < ADF4350_MIN_VCO_FREQ) {
> > +               freq <<= 1;
> > +               st->r4_rf_div_sel++;
> > +       }
> 
> This is a reimplementation of ffs()/fls() or similar calls. Do you
> have a plan to clean up?

Oh so? Not seeing any direct way of using ffs()/fls() for achieving the
same as the above.

- Nuno Sá
> 
> -- 
> With Best Regards,
> Andy Shevchenko

