Return-Path: <linux-iio+bounces-27376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED894CDFFC3
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D807303FE3B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229F325722;
	Sat, 27 Dec 2025 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlvzTBex"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144B325716
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854454; cv=none; b=rEqgz8okwpnP6n1f1PF3Dr+kS7Z/i4S+unAzJwgn791NhSs11RBWIb1Py3LQtUMTCebbHldOlYKPOiL16UPGAQDSK6V2iJGSTx+4OOC/EeOzFDpk/VOFhpadLJlN7dPFmclvBThi+3TPloAKTWeP2nOG3AS6pq5YAJnrGTVr/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854454; c=relaxed/simple;
	bh=fEYdGJTBXajaUrNAsrK5tA6o0RHNKjo0+Wl1GKYTiuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wdf6i50qfjRG88JhXXul569UwBSDZQMCTxWdLOtc1LIadmoYwrCJOVKOYiUktovBQxrKPA+UmjTK8Xw2VOICuNSKOOhM9mYo4ixhTNoAzyeV48BJf/WFb1vzwmHSXXvNPSEAfBgMXaJSClQ+naBsrTpqm5w11ivwgfvBYTv7kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlvzTBex; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b736d883ac4so1359763766b.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 08:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766854450; x=1767459250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEYdGJTBXajaUrNAsrK5tA6o0RHNKjo0+Wl1GKYTiuI=;
        b=RlvzTBexLB8vAH9j/twWw+A4hf8zyUwpSag9hVrZrRdef+TBEGjtluQ3iLfRX6EnHx
         wtDCy/eKiNCXiufxq8HszBiil+7q3FSdE85cP/wRuLKi+XApPDz662t5ZvIQMBAcBOma
         Z5UR1B4OmqD7WJbmd3zQWk9foHN0RnrhtqoKjYxpyJFpWdAiRsXRraGCEEaNpJxWpMed
         pK1GUSb7N+JRj4sJzZ2Bxr9kp2r00KKWSSRhaMBFr+IWxrc0ELvPEtR6rjbAojNe6Pt3
         pqY/oIvwBnYRRmbg65ek2wyq6CGslxXZt3/cnDfm7I7S1GYYHAGH//MAs5TV/NrVCPTT
         tnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766854450; x=1767459250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fEYdGJTBXajaUrNAsrK5tA6o0RHNKjo0+Wl1GKYTiuI=;
        b=pCGZ/Kw7/2iet5R0L94FiRVsq+nBh4W6vf1Wmft6KlLIkwoEMxPAattJ/EHJCx5GLU
         4EawdZXo2XWtMRRAv9ktnDBMODF68yaJjwZ4wCXDFanhUaVO7QYnyMJAz9N2Wz8fYzrG
         MbOqm52+c8/0ASBwvONjMCGMlHeDNMHGVsRNN5z7ApPvMbE4F1lhaH7UqSEDbIpvqM+r
         bUJI+r7VcV7z0X/n1Mdo4ZqhJTjGi52gAGrnz5hAHuIEsM/tfLFfpOpo2dupcR1/MVsR
         uVUkt5Wdsr6LjyYfkTYMr5dS5+X1qc73VfyD/b37KSwnpaLEarFXqCt2BG35147d4TFW
         r05g==
X-Forwarded-Encrypted: i=1; AJvYcCUVvnwe0MzT+BTmAupTbthRQZGsgR8fvBKH6/pRFoKLP2tAGoEVNGdrlwjYpmuV9cMH2rt9mBeoU/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6cyK4IOnDr98S+FXBn9ATOuAemXFeT3kqDsy//M19FCdA0jh
	bfnsGbTbqT49m3RhdIdZtr7rExjQ8h0+KdF5/6bBfxFbIhe6z/fWPoR6Bcyyq25RJpWcUq8EbEd
	SyuLoIv6y4BHwE3v0AXI1CM/IIpG/sndeLC7k
X-Gm-Gg: AY/fxX5oxcgo6Ugm3gluvv7gYyxalouY4Nw8CjpItyunfL5s45KYb59PY6vi2C/JFJz
	oA31QrmGf7/mNqyytZ+ZV1joCDWXoUaUN4ITKRy5rc+jV2IzvolCZtuv7SZCVxEvElhWkMa9WpE
	5xBxawvEXP+h7v6ZfeyKe2KLH3fTjwKMWYcXUgCHcNaR+PEkkKmg7rI03VO/79dubt8SlQUb26b
	nsnBJ0C7WLC3lFRofvgUAi9b+KdU1GEbIo+5DO1tOk45PsVtMeIJIR211SPasqPbDxRyu/f/1Vf
	X/z1JOZjWUNNDeV9DIt2FJYhm0Bf9bM58sSB97qRQaiMu/U54WUYDIoQbuy4snyYKNkdBhM=
X-Google-Smtp-Source: AGHT+IGzhdKUm2kUh6gBHGyRHPs5NkLVgUF1gZqV6A7v61VPEy5XWWzE5biUv9XfjwATbwqlgPYDe2MvbumQ7GhMMY8=
X-Received: by 2002:a17:907:3e1c:b0:b79:e974:4060 with SMTP id
 a640c23a62f3a-b80371d7db3mr2912543166b.48.1766854450421; Sat, 27 Dec 2025
 08:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
 <43504217d5b3c32da946bed0ce4d81e216f7c7c7.1765900411.git.Jonathan.Santos@analog.com>
 <20251227155525.6d712f42@jic23-huawei> <CAHp75Vd0n+aTkdzMC53y9LrPW4t0mckpzmmud4Ez5gXbAdLeVg@mail.gmail.com>
In-Reply-To: <CAHp75Vd0n+aTkdzMC53y9LrPW4t0mckpzmmud4Ez5gXbAdLeVg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 Dec 2025 18:53:33 +0200
X-Gm-Features: AQt7F2o5pKu3JZDHtQuLDnXH7bgPd_iJLkPg7pb83Ops5_qMZGPLToR05RzuF8I
Message-ID: <CAHp75VfA3Ww2N9CA-gUpko7=s===s6DDM2ik=w2NJ=mUQqo4XQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] units: add PERCENT and BASIS_POINTS macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jonath4nns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 6:52=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Dec 27, 2025 at 5:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> > On Wed, 17 Dec 2025 02:52:45 -0300
> > Jonathan Santos <Jonathan.Santos@analog.com> wrote:

...

> Also there are pp (percentage points) and others like per mille
>
> https://en.wikipedia.org/wiki/Percentage_point (see "Related units" secti=
on).

And given most of them are in the PER* namespace I would use those
names instead of variants.


--=20
With Best Regards,
Andy Shevchenko

