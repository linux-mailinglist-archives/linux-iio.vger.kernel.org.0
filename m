Return-Path: <linux-iio+bounces-23315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A31B372DD
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 21:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF181BA5A69
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68CF350830;
	Tue, 26 Aug 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/OP6+27"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7D86342
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235453; cv=none; b=GKlGSjbwr7r5uWO72/xnfVwKPn8gNzamqHRz015x5Bl/++t3lRKKPHOxRpQXZ7JD/gJ7tZfkXn4SBcMuAly7jbalhA7HXy8estD2vwCXaOeI9ilaSGDubENh9MYan8MRYjLyJCit/x9CK4yuBFYujboBCY8DGwCZJ6eSpAHFyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235453; c=relaxed/simple;
	bh=sYKuiAsM4isLGCVMmKUHyt8gzP965rdusshsguULdfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuKGDFmKin91PWGHmjVQuB6t+w6DD5sWIVKBSOJeFnAHws+q+8mSaQN0plLIkqT3s4crNBrNYBYKp+fCobRMbK8dsM6M3rwfPOebXnuJAuDGoAW9frIJqBA/R4sbxfm50bWoXTMvSop0LlJTtgUT6hi8/gGoAbNl/4CaBj/LGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/OP6+27; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61c21e50168so5695549a12.3
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756235450; x=1756840250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYKuiAsM4isLGCVMmKUHyt8gzP965rdusshsguULdfU=;
        b=T/OP6+27ElVL4EW1kOcNhuGciFUwKYMS+Gv1sFO31Ds9fZIlmHz1wzSvORzW1eRO78
         GOQQgBmUtVc3EGCBp5jY8fyNClZMaSMcATaJ0KJiLiMVepAZ+2H7fUz6OXYjmgi+BMdW
         JsnB5etXW9FF+CcwL04BvypDZBQmpBlGltrgZg/+Czr3enqk2m16iaGZIGjE6HRieoaq
         q8cno0fINK/nQj6Th/fE6qa3nN6tsb6eLDbY9/1+1CHTLMTy1FwHtr1uBpiz/8wRrtUj
         qdbnDLyUbfIlOUghqqejQrzwpEt9caHRA0zL+jQzQsomsJrK+lLimRaHVMn+cipS73lR
         2sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756235450; x=1756840250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYKuiAsM4isLGCVMmKUHyt8gzP965rdusshsguULdfU=;
        b=xRlh8iQk+vHXSgDGZo6LcMvvEI7ZdS7z+m4OQebcXnEh0M6mebrCDV0Wsi0fOWOAmW
         crgXIONHXbfC+sLKNv8tfq8Yj/sU30Ho0Yj1SDVIgfQMheqQqTHyzOaUnNsNWVj2qxyc
         gt513Gw7OCjry3t1Lv3G30OaxmcDMXEYiaHxEm8xVMG97DMi9OalF8hgfRkEHXwHltf1
         bDYqyUsh49y+g4Vx/lZjtlkWYe5XrLCAv2S2AmFu4Rnn0DkPCpCgC9AIHv5cZnyJzPgQ
         Jl9/0w+XYz2VX3L+rsYAEGvNdVw/ut9olnDi1y50jZzkfAJQ2xU5NLrvK2hIr444vVTf
         cwhg==
X-Forwarded-Encrypted: i=1; AJvYcCWKtQiSs8AcejfEFMUCxNQP6OqXa+AIxjCBmcxokOMgB24kTCIYlHAjx9u7wpOTj9Cnb+8PhqYayGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVTDBZT039SFwaX44wnjQB5EK3wLjSUrVl0dhd0cHjubM6w18
	Z3IL/YuZ5/6k1sGiSWLzPHz/1KkJYZ8uVMH49A7LsI6T0Rbvd0Kf91UMow9/FdBj+rPDbpIRWfj
	KCe8wTpfdzMZLJhBWh5n2eIbMQknuLi8=
X-Gm-Gg: ASbGncs1yN7epVPNs4G1C1M5k8sknuMSwa1+CJhkdMMbwYoPnYHQU7Juxzb7g0vsuc6
	3o2/LD7kQj5UEgmtIk2M1TOibSi26JSJXqHkcpn26wnid083sF8RsZClscQZz/Kxe8H3H4TBJHD
	AJzWJUvJbjZGHH0ghPs6NBuxCYVFEVcK/agzAgLHp5FfWTZhwHEUFMZdET9wg/x2d1tuUL16IAM
	0KUeizDMB3SO0bBTCNeb9C3V4N6cwLbySbJUV1REA==
X-Google-Smtp-Source: AGHT+IHV6T+opSXl4/wTmC0jPSV67txnBJeLtenlyGfnn4TDzGZEZtL/2mp5YoLhFe/dAM9xsLN7ngTC2qJTUneKyZQ=
X-Received: by 2002:a05:6402:35c1:b0:61c:5cf9:c690 with SMTP id
 4fb4d7f45d1cf-61c5cf9cb1bmr8057670a12.5.1756235450069; Tue, 26 Aug 2025
 12:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+D_U3F_61vzXPHDZV_Rm4Jzd--nO3yf083g7-0=Hh7OFw@mail.gmail.com>
 <CAHp75Vcte3F3VNhKZPd4vv45Kedzok0LKQax1jt=geG9w7b1EQ@mail.gmail.com>
In-Reply-To: <CAHp75Vcte3F3VNhKZPd4vv45Kedzok0LKQax1jt=geG9w7b1EQ@mail.gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 27 Aug 2025 00:40:38 +0530
X-Gm-Features: Ac12FXwoE5DB65f2Eilh7T9DT7SDAmCkip0R7LF58eSrK8zAHrWUJjPuhnq5qCk
Message-ID: <CAJE-K+CNsGdJWeYW-NL7PtkOog3YfLEeqJLJRHEtTfb=A=o8pg@mail.gmail.com>
Subject: Re: [PATCH] chemical/mhz19b.c: Replaced datasheet reference to new revision.
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "gye976@gmail.com" <gye976@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, 
	"dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:34=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> Commit message is not an email in a free form. It should follow a
> specific template.
Thank-you Andy, will keep in mind for next.
Sending a revision.

Thanks,
Sidharth Seela

