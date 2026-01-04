Return-Path: <linux-iio+bounces-27475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35FCF09C4
	for <lists+linux-iio@lfdr.de>; Sun, 04 Jan 2026 06:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EAD7300A6C7
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jan 2026 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113632D543E;
	Sun,  4 Jan 2026 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZtyr1Kh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53A2D480F
	for <linux-iio@vger.kernel.org>; Sun,  4 Jan 2026 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767504326; cv=none; b=lwasSk8x5+HNiSMtr+A1OBOVx0OfHzKWdwWx60NA2ddrQQLLNuz1MaXR31+/iQvrKe5mF3WQBpTAom6Knmv35tryUmLgMJrTvPZ1BbHcy06Wtsoq0dRkrEaLHlyPyVHuC1iFEKPm7Q16XIoZT7gKbs0EcjLBVuIjFzpd62hXXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767504326; c=relaxed/simple;
	bh=I3WCzlV2edorTmg3PJ7toRE7SlA6LWsaLpA8+ZFEhQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l08IACpFYoXajP6pAImnj5DlaCMMrLLcM8FjTsNdF9TYi3HReRoDmEztI3UoIWoTT2Wrg65qRWPM5pi/6obN2NnQ9wqqPYc77xmnBKT8zXme/8tZYu6dwC9Gq45EZA7TJJjzovZFtolfUwauF3rWnMAFUGoX870FLq+GI6TpxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZtyr1Kh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso12536156a12.3
        for <linux-iio@vger.kernel.org>; Sat, 03 Jan 2026 21:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767504325; x=1768109125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dQEr16uxByFpZ6dsm0QP3DXZzS+3qaAEyzf1bKeZK5E=;
        b=VZtyr1Kho6cwwmmNHQ4xS/5DLT8TssyINGTNmxrLKEFzsHbuu2Ghc2GdSYCKwP8pJR
         YmyvARUCTHdXvpHCAhoaX0B3FIBqa5Ch9gahVzNcabXK8jKf6djIxgvOsJ47tM35Mg2f
         oYig1KLFFhQMJ8NhPF3g/nJtAeNc7hQ01HifpaTdc2Xfjmx4gcvsIh52AICQso/7cHaD
         cdc0F7qwshyAw9Rs1qncnyRaw8CovpEh1a60zP/zpK16RHE6etamoKbGhAuLU5uhNryq
         rW2YayBRqdVwoRDEEeSpDIKV/dlztLlO8sXA/LL40RYCFiYbcFYBjvxzjhfwLz/lSDM/
         3wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767504325; x=1768109125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQEr16uxByFpZ6dsm0QP3DXZzS+3qaAEyzf1bKeZK5E=;
        b=CKdJ9EnpQ8pj0kUkOr1NadGiXRw2bZ6IaBSCjdhDZt7rzS0fOMnc7+M4En9wQnVPVL
         95/QAkfgF6CR9ZH02XaA0f6TNhaZByjm2bT09dX/puDl2IzuCPcWALSczAyAuEe20dUz
         G3DtVeSpQCaIyqKPDYY4kY8kjvs0ULhB7Bi1zWQ9vH7qzQfaSkMAkJmDK0haLhxYVtXt
         qMKeAzqhPj4IugVx2depiG2VyMzU4gwhc6Ap/b1IvUiaVJrKFk3HurGFam556ybDke/i
         DzS8EtpgkTosbvwEwjJfOdqp5oP42o8PEWbSR2OI3mBeD8BzLepfQdvelPYv6V+HS+g5
         Qyiw==
X-Forwarded-Encrypted: i=1; AJvYcCWUzCp2Gqiy4fp/nfWdTtGHfQQu1/aPMfOHcjnHYn7Pv2emNgtrX57U40nst5rd5egBx73jLLx24qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzM8sskFJBovWm4j0ybTNtn5ij6j2uksA7QE6WjE7lo3wjc+hd
	Ok8atXrHE2i2b9qn4WuEqIcgA1+eWprQqIcUa8GPUknu3Hv9h5u+ssQQ
X-Gm-Gg: AY/fxX43uSzsOzvUjl1QJbrWOf6FK4Gtp36VdW3Kn2Cn7NbXV/evHscVUPxavF9Ij9/
	Nxad+ippH/oQuIg3s17qksz9MHxOqTubh8hV3KzZJSly034KHPsQ079CP2QVoAO7iAumB2eJ2Oc
	aYiwUO1QmofnVWZnDzQJ0PrXg+Ko0vawTRnIJaMng3XwY1Sq5lraL52PyjwOc2qRtlhd+tiBV5r
	QmXnxAV5YeDcihAtzu1ZXMCcJhQMyCMqGDX+Jdw6+lyI8Mfv4PAkUcoxDVIOtkTC/u4UA5D4kKA
	4vdVv3vu+apUORGOkSbPyhNuhLc58TiMMwpTr2ERQq5OfCkp5u4Tn5ltMOfTbHqB40md0a5aohQ
	RP7iPvkifXXT+evAomSwEk2X/As7HD+JhwuKbsHkFrxsRlHG+F0/aG10mMhSDCwMmePVr5N6F6i
	EHoT8gEYhkHiHESWOwIiSY/tFLitrtR2MsITaGegODO9qhr29l+hqBXM0EQKnQzQC05EXRsrLlu
	1mCW22SKW/qsEnPQ6o69c6VgC+fCYt2m6ea0oAMexVC9fZ/LR0Q7hGpvaw=
X-Google-Smtp-Source: AGHT+IGv88ZyKsdGGf/yXvuvui+FMzWsvVI3MeuxnLqxqPfBAUWpeCfAt+yWc6QsN/FnF7dCNxMOnw==
X-Received: by 2002:a05:7301:815:b0:2b0:4902:c189 with SMTP id 5a478bee46e88-2b05ecab250mr28973064eec.33.1767504324670;
        Sat, 03 Jan 2026 21:25:24 -0800 (PST)
Received: from localhost ([181.191.143.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fcfc1b7sm97642003eec.0.2026.01.03.21.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 21:25:24 -0800 (PST)
Date: Sun, 4 Jan 2026 02:25:23 -0300
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/6] staging: iio: ad9832: remove dds.h dependency
Message-ID: <hjspdsgz6ey7iaczw3qxn5qwlmpv7pnhxxmrzmfigygc33at2r@3gq2xps7idza>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
 <20251230203459.28935-5-tomasborquez13@gmail.com>
 <CAHp75VefAPs8C9gJdz-zTkS3cpExg5pwOTMreiUs-ikSgpygOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VefAPs8C9gJdz-zTkS3cpExg5pwOTMreiUs-ikSgpygOw@mail.gmail.com>

On Wed, Dec 31, 2025 at 12:46:28AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 30, 2025 at 10:35 PM Tomas Borquez <tomasborquez13@gmail.com> wrote:
> >
> > Remove dependency on dds.h by converting custom macros to standard IIO
> > attribute declarations.
> 
> 
> > +static IIO_DEVICE_ATTR(out_altvoltage0_frequency0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> > +static IIO_DEVICE_ATTR(out_altvoltage0_frequency1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> 
> Any particular point in not using _WO() / _RO() variants of the
> IIO_DEVICE_ATTR_*() macros?
I was looking into this and saw that the definition for both _WO() and _RO() only takes _name and _addr:

#define IIO_DEVICE_ATTR_WO(_name, _addr) \
	struct iio_dev_attr iio_dev_attr_##_name = IIO_ATTR_WO(_name, _addr)

So if we use it for frequency0 for example, it assumes the store function
since we don't pass it:

static IIO_DEVICE_ATTR_WO(out_altvoltage0_frequency0, AD9832_FREQ0HM);

// Expands to
struct iio_dev_attr iio_dev_attr_out_altvoltage0_frequency0 = {
    .dev_attr = {
        . attr = {
          ...
          .store = out_altvoltage0_frequency0_store,
        }
    }
}

Meaning we would have to create a store for each one instead of using
just one write function

> -- 
> With Best Regards,
> Andy Shevchenko

