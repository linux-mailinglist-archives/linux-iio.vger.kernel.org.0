Return-Path: <linux-iio+bounces-18460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426CDA95293
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312913B3BA5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333D13D246;
	Mon, 21 Apr 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZklzjIm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34B35961;
	Mon, 21 Apr 2025 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244981; cv=none; b=gC9yMtfu8K39oxVnt0ZKUMwluLuSTAvzS9efPZ8WbDvNc62/YV4WGz1jL0DL/2vNZs6XTUnMajUErnL/ebGt8RjgD1FdzHABO+0vX+W0bLkxUjJL5/AgVlWc1g+hqIzBH1MSoDci8/TfiJJIzZG9mbr+j9SJID0iNaGOKO8F6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244981; c=relaxed/simple;
	bh=AiGnNSmslAQcJ8E34wzKCScAL+VTPdg07eYzTNVuK0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Omxq1hIeFB4DY72OPLc/jLn52BszGpGnuK1gZhrgDYQs7vPHMZjTQK4Hi1+76wISSM22QWZ4v1HSk0HcMtiUUN34Nw25+OdSvWjBKKCDxVnvzi78bewprZJBF7tGGYWZiKTTP+LtNMU1P5vREaO/UM+jb2Rkjc7i9a7cGI3DNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZklzjIm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4769bbc21b0so39140471cf.2;
        Mon, 21 Apr 2025 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745244975; x=1745849775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiGnNSmslAQcJ8E34wzKCScAL+VTPdg07eYzTNVuK0w=;
        b=JZklzjImn9qj+kWvqO+9TA2jhzDEvlz/BZB7Ko3DKhecikx+VI5/UQHTyGTxnk5tx0
         9XHBVUDby14NYP089juz5mMmjB+5sEj2WtUYfR7YDrRqvIg10qc86RliApYCuCY6WM9o
         HVPnIzWX22+bZj1Q9fqxTe8aMc8ZFlNLIwH0n7gwwXhU59gn7t3r6E8u+1naJ+KuSCc6
         9sumBLh7j3wjINj5X/LzaU/aXdrE23W4A2j91MRPCNJkhff5rKZ/8q0v/aELUsQlAzPe
         mpnVSu8EOCR8Edx6l3QEB2tg2zz4aMupKr4W9hzgcRSTWQNoumSHi+6znHN72aoxes4R
         zl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244975; x=1745849775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiGnNSmslAQcJ8E34wzKCScAL+VTPdg07eYzTNVuK0w=;
        b=ngYs1mpqAIz309xXpsaCtvA3UoGPo8yFR2XMOXtTXsatjSNRnzR/6DwW6XP4EeF4UL
         ruulRgWJKEmJUzIYHsWYoxS2o5cIFwHYtaDxcqCGUvFgYXjVnuXkxn4f9ju9r3luCxqs
         EHgB+3pi3rFa3mkRGR9HO7g93dATN6KFsuCcQDCDrNcFzIoz2WgWYF3uzKuGdNFNAu42
         gzkzbzpyMeRuSEUWW4ipL8zkYZks6qoVi3ovW2njE2BEK/RGBbniXLU5qZBHsUTp8Exk
         qjt1ElE10YjTsckru1+kgyZoLNONLbY8mLSrDKYj87JLPQQUruaTPHyiqeFTsYuzIk91
         z3GA==
X-Forwarded-Encrypted: i=1; AJvYcCVZNyluPyiTATOtsf4AQci8ftlAZIPbdFLdldATkRKYJl60/+5odiOgBXkfNzwb6ZovR8qm+791L3yHuCPs@vger.kernel.org, AJvYcCXzKrEsK1ZwRgt6a9ujnlZ5gvOUrxRXEVW53dXHBotv3NExoXb/8Y5TAg3VehjSiYXg5KtBy3Z6@vger.kernel.org, AJvYcCXzUwF4WBGDhMNUf1yqdc0pgvjKkjw25aWW4GaiuykgcQAAQNYY1aPhoZImTBYSSCQEZhjCW2jW7WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfa+TY073pk4t5jy3/T2ixtTvM0cMLvLsy7QOxMbNJNbwmnlQD
	InJXgSiZMRybfM/21UAv1CCLldAF8VywFC0ImK1dEHsz1bARq9HftRuqQoMT70hzeiXMcZThtsp
	8wo6O3ZiF2gxCUCGW9/w9c71RKxJE7/mUdVU=
X-Gm-Gg: ASbGncujokk61nqW0kzgHDHJF/z8uJD0HXezt6fD9bbyM0HsV7B7UXHxS2BvTP+XEYS
	JiR9rPSFtR6GAChhzxQJZdp1id+BpejJ3pwgJYC0WiiVN1jledkgTZE6EyF8tVcbFyWyDLR/HfZ
	cS+NcHWynnzwbPsvcldy/AdXvjL2sI8y2OAv4V1fdT+5Ts2JHDSZDKvA==
X-Google-Smtp-Source: AGHT+IGPDbjwaGUH4InYWcFLu7kBF8JZsjStf3YQR+5XpjFvZ0PtISHj2loyaOYzbIFa94xiQWzEjDkG2RlxMJV7CG4=
X-Received: by 2002:ac8:5d16:0:b0:476:b4c9:f4bc with SMTP id
 d75a77b69052e-47aec4c5774mr209697121cf.46.1745244975597; Mon, 21 Apr 2025
 07:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421124915.32a18d36@jic23-huawei> <20250421131539.912966-1-gshahrouzi@gmail.com>
 <aAZNCEUejrTgy_yZ@debian-BULLSEYE-live-builder-AMD64> <CAKUZ0zLEacGg5cD4wGmFz80e4FQ9A=JsVyrzGAHkKEeOT=CU2A@mail.gmail.com>
 <aAZRRfO1AmiHs4Bf@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aAZRRfO1AmiHs4Bf@debian-BULLSEYE-live-builder-AMD64>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 10:16:04 -0400
X-Gm-Features: ATxdqUHEnmhxi2h48Tjc7gu63ef8gOHHrO7_kehbD9oBxx99ugywagJADQennYM
Message-ID: <CAKUZ0zLk8OCgUUVpcFRygpY+iDYjm-=8kHpoosZJpAtyyeL0AQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:06=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 04/21, Gabriel Shahrouzi wrote:
> > On Mon, Apr 21, 2025 at 9:48=E2=80=AFAM Marcelo Schmitt
> > <marcelo.schmitt1@gmail.com> wrote:
> > >
> > > On 04/21, Gabriel Shahrouzi wrote:
> > > > The inclinometer channels were previously defined with 14 realbits.
> > > > However, the ADIS16201 datasheet states the resolution for these ou=
tput
> > > > channels is 12 bits (Page 14, text description; Page 15, table 7).
> > > >
> > > > Correct the realbits value to 12 to accurately reflect the hardware=
.
> > > >
> > > > Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > >
> > > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Should I have included the reviewed-by tag on the latest patch sent in
> > this thread since there were no changes to the code?
>
> Not sure I had given a review tag for this.
Ah it's probably because I resent the patch in the same thread.
> Hard to find the previous versrion because it doesn't seem to contain adi=
s16201
> in the subject name :/
> Anyway, good thing the fix should be added to IIO now.
>
> Regards,
> Marcelo

