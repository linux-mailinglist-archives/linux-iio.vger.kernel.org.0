Return-Path: <linux-iio+bounces-1503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A78E827A1B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 22:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382911F23D56
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 21:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B055E77;
	Mon,  8 Jan 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzNXdrUu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC655E6C;
	Mon,  8 Jan 2024 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3ed1ca402so20012715ad.2;
        Mon, 08 Jan 2024 13:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704748533; x=1705353333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAJtUP64ltD9g/AOMY/RTS+amnQ4+ix5NQibCsD1n70=;
        b=NzNXdrUuETCvXZORTsfPKMB+IhnJ6LRVs8j1R6Sx3mkbnynw/l98aQDoP8rJZd++yl
         +0eoYb7aABzBhNtwYeWnt02WE9EvXkxT3XcBC9P3NuuF5c5BCJ+NfpHY7BGa1O6tP2qq
         K4A6OeYWHNeuYXYhiTLTdApxA5FQXhyQexBjXAYqOnrB93QglyWKJ0/S0sHZ/CnljqKI
         rIVfRaoOtF6welGmA8Q46mMK2bTIKGyEFjG/94QSWPk9UWptGimY30VmsMtwPKisOWi3
         YPnMPOpavZqsFWttbrDDqJbbtdnKlES4trW/bI+AAWMnmGhjt7BzFLVJ6P8EjJZVMYYZ
         mOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704748533; x=1705353333;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAJtUP64ltD9g/AOMY/RTS+amnQ4+ix5NQibCsD1n70=;
        b=HrQn61O3/rLpc5rMsL0DGC8pQuH6dbYA9TSUlCt5QpdcdmhwHoCQ5AA21Ke9weTCFs
         2IyZzYFc6mT83nIvVv8EKoppZUqOVULW+bJK+Y0bNzSl7vz9s4I2y0UMW5CU9kk76xQU
         nKgB6Y2lnRRRaUkov3dDn1B1sCLjVVZl5L+AzTSmiDDFbUAq3gOHSJf2RS0ZiTg5+JoS
         bLpy0TJJZPiOavOF5IVcQ05Ol7XAoz0sGgY1DwXhfIM27V3tZTvwGK6KUQXG2dVqhc41
         VA19ns2wseup2SS8HtDTatwwSSF0Ew3dNVns5AQwAIWR3ui0lyuZba2jreW5OAW5uhTx
         G3hA==
X-Gm-Message-State: AOJu0Yy74lEUjCxbK2Hm56LJprw0fdmeBpJUnkyV/Ue30oqC9PNhKqG+
	3s670n+l90G/K7T7wj4KJpVGFhdnSQjCR4JrSDE=
X-Google-Smtp-Source: AGHT+IGSpibIP9a0Ad9ww8Hkp5J6+DgsvieH1JdcE4dqqbW9KHb2Nk7jEx7hOqmU9E3kN4dMaUU8HVSRWI6lPvFzxjk=
X-Received: by 2002:a17:90a:f285:b0:28c:d8d:e05d with SMTP id
 fs5-20020a17090af28500b0028c0d8de05dmr2367247pjb.39.1704748533026; Mon, 08
 Jan 2024 13:15:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jan 2024 13:15:32 -0800
From: Amit Dhingra <mechanicalamit@gmail.com>
References: <CAO=gReEUr4B+E2mQsSrncHf41f0A915SuoWgA522_2Ts-dZbSg@mail.gmail.com>
 <d537ca6c-180c-4f35-8441-adea03095689@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d537ca6c-180c-4f35-8441-adea03095689@moroto.mountain>
Date: Mon, 8 Jan 2024 13:15:32 -0800
Message-ID: <CAO=gReHX0+tVzrdceeT=NVkQhRvF1xO73fup-nYjStY2T9x4BA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: correct file entry for AD7091R
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 08, 2024 at 10:56:02AM +0300, Dan Carpenter wrote:
> Generally, patches to MAINTAINERS don't need Fixes tags.
>
> It doesn't matter if the patch is in mainline or not.  If it's in a tree
> which is rebased then maintainers will fold the fix into the original
> commit and the Fixes tag will be lost.  But that's fine.

Makes sense. Thank you for the information and guidance.
>
> Also when you're using a Fixes tag, it should all go one one line.
> Don't line wrap it at 75 characters.  Just go over the limit.  That's
> the normal/correct way.
Also seems like checkpatch does not like the Fixes line without the
keyword Commit. So the fixes line below generates an Error.

Fixes : 7564efb37346 ("MAINTAINERS: Add entry for TQ-Systems device
trees and drivers")

ERROR: Please use git commit description style 'commit <12+ chars of
sha1> ("<title line>")' - ie: 'commit 7564efb37346 ("MAINTAINERS: Add
entry for TQ-Systems device trees and drivers")'

Adding the keyword commit gives no error.

Documentation shows to use the Fixes tag without the keyword commit.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

>
> regards,
> dan carpenter
>

