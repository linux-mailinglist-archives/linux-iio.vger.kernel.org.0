Return-Path: <linux-iio+bounces-15085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5BA2B191
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 19:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424AD169FB4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB0719E99E;
	Thu,  6 Feb 2025 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSb8bKjl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80F19E7ED
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867603; cv=none; b=F3ep3tCyWhBz3T/E/yRmxg6RYNwVJvBFicFUIXzsnlisWTDntcwS6CqSp4XNsISrJH8RXfhwEvZvGdhYZq3ESSrBXgxYui0DEvzAspWGkByzIg07+9CU+N43fOF3/4cH7A3xs9lX2XOq1IYBhg3eIlNKEeZmbgA3KTxORGPch6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867603; c=relaxed/simple;
	bh=P0zr8OoINeTGs7g0sjgckyXehEfeKe5nFPFZvgr4A7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAdzxJq4NGZUX/bOAIEkUvMKvaCURYkCylTpQ2JUEje8pIwpuZTFa3NIB3ZTMQaqgHIZ2M9I+bLhNRm5a8APuZHysx54IykVa0oZKoXoyNhUOwKJgkuRpOfa+/Sw+lPKrClMtsfI48h2t9Fkm76Ke2LB3i87+ug6bE/TJh/qh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSb8bKjl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54411e3c610so790153e87.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738867600; x=1739472400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0zr8OoINeTGs7g0sjgckyXehEfeKe5nFPFZvgr4A7s=;
        b=HSb8bKjlCso8Q2T33K6TqG78MC1pBc6iML9i+BJ8Q0DgT9npYfT9ppCDFnD8y26dIO
         q/bS5EVPVi0bwLw+Vf13weupn53gFOnG6j8UZB0r6mPsrIUzmM9AMXW9Q1sWhpK/ZvXe
         pUpJUj+ITtePG3fvDFxFRoc60DY/bPX6ssJ/mXBpmZ53Aa4ZMzX6aUSJJVaXWRm20mkV
         EL3ZyJz3zSio1/7DKWPuAWOP4VahXA735Hkg9ngvlmFLp0nr/wwFT8b7P35MVG+5q1Cf
         8lKMd53PhI0MoiAWFLrBlsoQpNgt+NQIFrH9x1RGdk96WrLI6MY5DU9xsUC7hG/UFxFa
         6HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867600; x=1739472400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0zr8OoINeTGs7g0sjgckyXehEfeKe5nFPFZvgr4A7s=;
        b=IuY1Fcqfw6l3mOwpsZyNHXrVETrwBEtfay8IvbIOES9QFFF4HkiVdMa1Z3mDLPHtCk
         4mmw5s+sqMLe6zntL++ZbpM1Q3BZmwm8su9A1dfK5BDGdf9TypgZmP11+mp2E73O79DY
         on3jl/v/E8QLmhp/7wPoTmh9S1TPPfXOF5TFtypOuZwACag8clYvGT56MUEzX9i5yQ0c
         vTJjhUE5My5+EaIye5zMvXP549tdTRIc75+n922dSA1/V/jxMOgu1V8u4hudY9BVPvL6
         rTpU9lTVm8EseqRMv0N8Ki/q8TxM4uFCWJ2rnlrkywvFF8FIFOVkrxiugKz4uLPRuefU
         HBBg==
X-Forwarded-Encrypted: i=1; AJvYcCXml7UhiBa7IoFk0erFPGGg/roBf4pvCT41sVZW1frYvwH+1TxMfAcS2lAujctW8qv4P0EGUBbd+rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoreTsj6h2VB90qWa8V6q2XxmAhucJD8w2Yl3UtVNg1r3iWXwq
	KJei3Q1PtecRR/s5VX5XTeIEC/pxEm90i2Ug5yWHzwUedNlcy7MPxL7P9Q3DnAKrARHeRSBIzyd
	f9MP6Hoj5jCV4zSMVyjyHqK8KDsZiMdfmUsxORQ==
X-Gm-Gg: ASbGncu4WRdJkcfKD4o0qeFM9UadJAAgaw43L2LYPClQidA+wkBi5h6IUQ0cRt+pdfq
	zKZL7m6Ovmw/SMnaAC+Ieb/CeCV7Ltl2uyZ2S95hQd/faFBvI7HF8sOy/ED8+p9SFZF032pw=
X-Google-Smtp-Source: AGHT+IEpzVZeWcxUUFevUxXUUtkE4eDoK/ekTj85xIIJYmnvT+leN3VUeeipd/F5aigtmYFlfRv7++sKlMafMRpOAt0=
X-Received: by 2002:a05:651c:548:b0:2ff:a928:a23e with SMTP id
 38308e7fff4ca-307e5a7c213mr216161fa.25.1738867598438; Thu, 06 Feb 2025
 10:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203080902.1864382-1-raag.jadav@intel.com> <20250203080902.1864382-11-raag.jadav@intel.com>
In-Reply-To: <20250203080902.1864382-11-raag.jadav@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Feb 2025 19:46:27 +0100
X-Gm-Features: AWEUYZmP4B2GJCmX-AuJOGL0VPK6_mEkpxI9o4n-GutRcEqg2kbz1wZ69XnDlBM
Message-ID: <CACRpkdbKzZ2WWEOE=ustPhL9GjmN3tkoAsgThW3ei7Gjstbp4A@mail.gmail.com>
Subject: Re: [PATCH v3 10/20] input: ipaq-micro-keys: use devm_kmemdup_array()
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	dmitry.torokhov@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	sre@kernel.org, jic23@kernel.org, przemyslaw.kitszel@intel.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:09=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> wr=
ote:

> Convert to use devm_kmemdup_array() which is more robust.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

