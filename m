Return-Path: <linux-iio+bounces-13857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6F49FE51A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 10:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE953A1FCC
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3901A304A;
	Mon, 30 Dec 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPxHIQ/x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53821A2C0E;
	Mon, 30 Dec 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735552706; cv=none; b=YqPsg1iO8HDTVv6OT82bM89qwypTvRFwVEiExNHI+x1S1Fxs0HN3N0rTtAyEg53dUJuOkmN/3NTgFoG2mJlBgSz6BVjqGbGas7UwJxpKP+c6ZHcCqY0XOwns1Qvi2R7Q5XWsTcZPYsWvriQYNIkZyFIdhkfjdB+Hmu6i8pjvTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735552706; c=relaxed/simple;
	bh=LMpsPTfwY1W792DoMCosJOMmGmWiaJsAtZEGqg1U2XI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=bbhG6xONIcJGZymUBSofGDSHgHVlTpxK0tnEdwaJvD8tY4y5Mj/pxJIQGyhT6eNz9pKldmR/ljVvqCO7G+jO7dj3MHlpu5YxXhuanPilvX17+aI+yHQ96dNpsrJwtYCsAtarZ+1Q9ZXNasUSTMNGffsPEvIl6BPJ34xCQ21E4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPxHIQ/x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43635796b48so54610875e9.0;
        Mon, 30 Dec 2024 01:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735552703; x=1736157503; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKR3CmUDPeca1b4GGjP6VSHlyziYNpuOYKwOZ7KV8Ew=;
        b=mPxHIQ/xg3LLn5q119nRUPvYgGJbuEI88lCKJYhfNCWsnIG1uq14v/SnrZ2v7M2X+X
         Vf+ECVaMoViNjFcYL2rpLvQGhgte/pnZJg+r1LKll3WVu6/l6o1wnZQRRcNsXUOtKBus
         zqykR2Lm1w2uRNvXbH29+BRDoQJAkIaLZ7m/T2i0ASYik0Vq6vTlseCfqx7X9DfaeR32
         H8GKRXq+g4JTPJJN1QYl6d7W1FXpK3b7OQTMF0INskIeFC4u+qFSW9QeXUtoQ6dLPPNX
         XfMEH97THofYifUs6iANqPzxtYouSaE1ArdevVO8wYUnHZcPDlbQjAtwwC/2nj1E75uK
         bB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735552703; x=1736157503;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKR3CmUDPeca1b4GGjP6VSHlyziYNpuOYKwOZ7KV8Ew=;
        b=F5866m2ERIDocsEkpfl/pShX9CngO16N5TgqYBrrSsLfVdxenoFWwdYZtxWQjbKOM+
         Ak4r5d+G+UlEXfh+9xme0NPuuoOdPW9F9QOS89+t6TNy3en1R+1fStZJDdUQbL4URIeD
         9XHe2WrKUZan0MYC+PUpDGSppXkoS7xv3vuoy+KgFSPG5biaxy5Ng6D7ukKBK2sbS45M
         bWcV1jzUx9eTVWJ/m7EocbaLglNHe8D2f7GeGRKpkRKy5G86rFC76OBTRHsgLAlg/68y
         QUgKsqX36w/02FwUXP2Wo6fiFqOldL2JXO6XCRRJ97+reacWhkWNo5kDD6uK7s7Vlu21
         rHqw==
X-Forwarded-Encrypted: i=1; AJvYcCWgBQaGF5ys7+oA44NQJek+Ry5x6R5lkNcXUvectShDLWh4f1Da4AlcFmVw/t34VhJmxSJo7JXvECc=@vger.kernel.org, AJvYcCXidKuzBSpV3x2S5We0xRMSMa+e4U9aRhYSHE1jY+26wK5rknMwDBFI379ms+gEkPgObmlPvoDpJ/VUBb0o@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzGkd3ObQAVLcT2pQAqWp9nKfCK2V2FjIJrPXvI0BqRDfU+fg
	URfvxPW3gcqB8uqqG4oTOG0QntDy56xvw25Kvtq8U2FCz7A5Oht7EiMLaw==
X-Gm-Gg: ASbGnctc3hx4CYAFKa8dA9vX8VrT8HuwHZnWU3fcjsKaIU0fMOFxRo8iOMLgbVd2BaK
	vdURjx0HkoCMvpSH3cmiVtFiC37Ib29PkmXJ6qKL0QOj814U7K39DuuCnpPYcFWW0QxFKvdyDd7
	FQLyT6bTetxH5aXs7nGn35eO83k4haS/4vFTsSWS2hYJXP27pUwHHm9O/VO+yM3tXye+dn1tvVQ
	tlQaziuXsGupUxZT1ip11+csXibBD0m2rKNjEegsUVpWy54XXPR7GWT9OBQlT16xwLouNH6W3yj
	uleksV5bQrLxbZddMnaxYKBUWw==
X-Google-Smtp-Source: AGHT+IG+Af7I17mpaNEMAVFnIJsnpSkD2rN+S2DtWlwPjNkrm8LZckN0glVCxrNJyHvgSD7+CRWp3g==
X-Received: by 2002:a05:600c:3147:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-43669a22df3mr285971885e9.11.1735552702770;
        Mon, 30 Dec 2024 01:58:22 -0800 (PST)
Received: from localhost (82.158.190.253.dyn.user.ono.com. [82.158.190.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b441bbsm382726065e9.40.2024.12.30.01.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 01:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Dec 2024 10:58:20 +0100
Message-Id: <D6OY33W0C0B3.29ERSR50BSV9N@gmail.com>
Subject: Re: [PATCH v2 1/4] iio: gts-helper: add helpers to ease searches of
 gain_sel and new_gain
Cc: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
To: "Jonathan Cameron" <jic23@kernel.org>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-1-2e1286846c77@gmail.com>
 <20241228154101.7f6f2e11@jic23-huawei>
In-Reply-To: <20241228154101.7f6f2e11@jic23-huawei>

On Sat Dec 28, 2024 at 4:41 PM CET, Jonathan Cameron wrote:
> On Tue, 24 Dec 2024 11:59:00 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>
> > This helper functions reduce the burden in the drivers that want to
> > fetch a gain selector in all available times or a new optimal gain.
> >
> > The former is currently achieved by calling
> > iio_gts_find_gain_sel_for_scale_using_time() for the current time
> > selector, and then iterating over the rest of time selectors if the
> > gain selector was not found.
> >
> > The latter requires a combination of multiple iio-gts helpers to find
> > the new gain, look for an optimal gain if there was no exact match, and
> > set a minimum gain if the optimal gain is not in the range of available
> > gains.
> >
> > Provide simpler workflows by means of functions that address common
> > patterns in the users of the iio-gts helpers.
> >
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Matti gave an Ack.   If you intentionally dropped it due to significant
> changes, you should say so...
>
> > ---
>
> here.
>
> Other than that, looks fine to me.
>
> Jonathan

Hi Jonathan, you are absolutely right.

I did not add the Ack on purpose because I thought that I had to modify
the helpers functions, but in the end that was not the case. Matti's tag
should have stayed.

Best regards,
Javier Carrasco

