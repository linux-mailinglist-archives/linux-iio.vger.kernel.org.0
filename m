Return-Path: <linux-iio+bounces-1505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D016827A2C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 22:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF71E1F23297
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99356440;
	Mon,  8 Jan 2024 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtHxMSPz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C356443;
	Mon,  8 Jan 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28d80eddc63so599538a91.3;
        Mon, 08 Jan 2024 13:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704749190; x=1705353990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB7u1cawCi4QdixdmpAfmjcFIxhHFQxnoht+bUbBK6g=;
        b=YtHxMSPz1Cq4JX/sFEbDaLNVKpP4uRCp/0R2uB4j1hGfQM7CXlvhQJ+zBlY8rL6tYi
         a7A21cB+9Nqq8siBzeHMXsToL6a4mv1OIcDXrRNpIRZ5E6oPvOLrbFpdTWbzodMnTIyM
         bcCxgqCuyBmmr8ZRRqlUTuimXoLw88n7UxdXX3UHWp0gZQbVMrrBNwpCpOEG2OTGLAp8
         ZOzNWHnJjh4nnJHDFqntKLwVMEPhw2j6PgZS7zC4ye9MDlJGV+mWGnwkOSrV6RvaHfC+
         jUk+BnkjN/K2LvMRfDpMGBUcqw6kTDSufLvFCl1NIbhDjyGUY0ec6pUs/GGCj2mRsNII
         azyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704749190; x=1705353990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sB7u1cawCi4QdixdmpAfmjcFIxhHFQxnoht+bUbBK6g=;
        b=kHzWLUcqebF1jJXdfUc3Hgq7xc1LDrxNnEho+lwi5eJpGuLtN+wQznuokDQjxj8ama
         K+4qhYizpbAC2zkuVY/nvcoZ834rIGWMZjJNsrFDPWEeGRLSg7lFJr3dlbecl3FsC21P
         P710eFiivt2bsd+Vwv5dnwt2xb3d5/IV+TrdCBogGpmAqMdQGiZ6MRMQasHXlvrpDYGo
         skmgwcZ9B35Gx41IRw7YAqdbrrYS7hQOLppBa8GjsY1ChgQ2LbS3F2KDg2bltVOnaPSh
         QyWnyO7puC+GB95PROJYFXdrKpStU8tMdT91tzUhzPGIHbFh71vYy3ooYVMcVnmVF0bw
         iUoQ==
X-Gm-Message-State: AOJu0Ywp8HCDui6yIF2++IPG8OK2sn6SfAZZnyJ8rs/zliCW6jeSmgiY
	uIeSSDSXpueMUDpPYOg89Os6RMymkbwpPnvRth8VGiZO
X-Google-Smtp-Source: AGHT+IEaLVCR11WiJXT3JAyJop1WZ8Ju2+l+RT58HS68CZXwLqD7auDJKPW/qCiEXjWdwNN7aEQ13MyW7zKnHkNN4a8=
X-Received: by 2002:a17:90a:72c2:b0:28c:a437:5ce5 with SMTP id
 l2-20020a17090a72c200b0028ca4375ce5mr1687697pjk.50.1704749190295; Mon, 08 Jan
 2024 13:26:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jan 2024 13:26:29 -0800
From: Amit Dhingra <mechanicalamit@gmail.com>
References: <CAO=gReEUr4B+E2mQsSrncHf41f0A915SuoWgA522_2Ts-dZbSg@mail.gmail.com>
 <d537ca6c-180c-4f35-8441-adea03095689@moroto.mountain> <CAO=gReHX0+tVzrdceeT=NVkQhRvF1xO73fup-nYjStY2T9x4BA@mail.gmail.com>
 <18d2e448-f3d4-4eb2-a54a-9dc9198b7260@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <18d2e448-f3d4-4eb2-a54a-9dc9198b7260@wanadoo.fr>
Date: Mon, 8 Jan 2024 13:26:29 -0800
Message-ID: <CAO=gReFomj0ahJomapnY1q_F-2YJFjRkWadFpiwvqCoNXA2Y7A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: correct file entry for AD7091R
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: dan.carpenter@linaro.org, jic23@kernel.org, 
	kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org, 
	marcelo.schmitt@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 10:21:51PM +0100, Christophe JAILLET wrote:
> Le 08/01/2024 =C3=A0 22:15, Amit Dhingra a =C3=A9crit=C2=A0:
> > On Mon, Jan 08, 2024 at 10:56:02AM +0300, Dan Carpenter wrote:
> > > Generally, patches to MAINTAINERS don't need Fixes tags.
> > >
> > > It doesn't matter if the patch is in mainline or not.  If it's in a t=
ree
> > > which is rebased then maintainers will fold the fix into the original
> > > commit and the Fixes tag will be lost.  But that's fine.
> >
> > Makes sense. Thank you for the information and guidance.
> > >
> > > Also when you're using a Fixes tag, it should all go one one line.
> > > Don't line wrap it at 75 characters.  Just go over the limit.  That's
> > > the normal/correct way.
> > Also seems like checkpatch does not like the Fixes line without the
> > keyword Commit. So the fixes line below generates an Error.
> >
> > Fixes : 7564efb37346 ("MAINTAINERS: Add entry for TQ-Systems device
>
> Hi,
> try to remove the space after Fixes (i.e. Fixes: 7564efb37346)
>
> CJ
>
That worked. Great information. Thank you.

- Amit

