Return-Path: <linux-iio+bounces-691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD1807B30
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 23:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1021C20BE8
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7EB563A3;
	Wed,  6 Dec 2023 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YXnF5xh8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F2D5B
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 14:14:36 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9f9db9567so102161fa.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Dec 2023 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701900875; x=1702505675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkJwWjl0YSKYG1VaG09fFZde4KGHyAQ6Ric9cwUDm5A=;
        b=YXnF5xh8xdHqNEcnfcsdwx/aWYSlqkZyZHc3RX9qYj7bC5nyuZQJNfgoKoDGdHX0LG
         1GjUWrRFOHWIz+0hQhBBw1340H8VVurC3/aJXe+26SCWceNtTIXAIxLaDWHUZgJaSQ8h
         kD4T4iCM5mGkD6e7xlwZOiiPNlfc+XEPtB2zbP6PfnG2/N5+efbP4ASCawq8f40B/Twh
         8GSktyg991Nf6qN1w++OWk1IUxPCj51acxCpq+I6R0nxYUdp21UQ4FxaAGgJ+7LBJSha
         DfAd6l97swF5fbY4X/3U4I489fSEpj8QYYBX6fQx6hPRRv5JK76sfDfZK4MENYLjcZi9
         Y2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900875; x=1702505675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkJwWjl0YSKYG1VaG09fFZde4KGHyAQ6Ric9cwUDm5A=;
        b=iPX+Uz2wYrGk86+Rnp/Pi4+utJLSFGGefdtKSeSBJobLwheoGMU/ipmxjCG2RmcarN
         JgDwInYDh8vFwv3NWoABDNV0rWGVMNuyw8WPr1R3pgqxleZ0T0x/sOUTW0qw2psP+Wb8
         J0T2v9T62F6y6Z47Iu18rjXSlyR8UHcCwjY2JVHG7aC/URmAWsL8FK4Kag2vSL04IetI
         vdm4bsa7mIPVEtgMtM7XnpwVOHJvU4OQfcc+LBq5JsW+A5Th0CUr61tUxD3avnV31mi3
         oUnBQAbgU0v+1lUGdjDYLLVXo0kVqW2i5OinkNZRUYa3tfmFprEVZ483sW0Te2bQ5149
         b71Q==
X-Gm-Message-State: AOJu0YzbvXVz07FqGaHFwyDihyuAYsNKtYjKkFCRqlwY00RVjEHxgo3K
	/lk2FmmeFCaMHvs3zSy4HITCZVI1KfiIgn5VMXCPkg==
X-Google-Smtp-Source: AGHT+IFwH5//7XgYhXITD58MClSn1Rt2bO5CxHoxt1n9RCXsX7ER8LRxciPbu9sagTS0Mu3ZZr+Y+LX//DTzDE2/jIg=
X-Received: by 2002:a05:651c:87:b0:2c9:ea5f:994d with SMTP id
 7-20020a05651c008700b002c9ea5f994dmr930408ljq.59.1701900874893; Wed, 06 Dec
 2023 14:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com> <20231205-iio-backend-prep-v1-2-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-2-7c9bc18d612b@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 6 Dec 2023 16:14:23 -0600
Message-ID: <CAMknhBHWOc7C5fErRxQCq5suHpmtUPbdf6sm+5YgXPY7uTLpWA@mail.gmail.com>
Subject: Re: [PATCH 2/8] iio: adc: ad9467: don't ignore error codes
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:06=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Make sure functions that return errors are not ignored.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

