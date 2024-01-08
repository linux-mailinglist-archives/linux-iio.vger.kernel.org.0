Return-Path: <linux-iio+bounces-1489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E74827541
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 17:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95EF1C22F8D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 16:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABAD41C77;
	Mon,  8 Jan 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4jJu841"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31C54BC1
	for <linux-iio@vger.kernel.org>; Mon,  8 Jan 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7cd5ab5d5bbso525791241.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Jan 2024 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704731610; x=1705336410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+fG5v+imY2py3wbXbsm/HP6trxiLASLFZtD6HV2z7k=;
        b=Y4jJu841FtIo9VBdJ3/36a3l1EJe44h3gsFB2pE5FgdP/F2OqMjyNEEDaNLyO/yjdG
         Pd7YSP6BulFO9k6AESdsV8vnAmpOZMbYPaHF2zjJQ8bSUtWcaqGe8zwOdjM/GuKAV/FW
         +x/Z7cr7d7/fLaBV7SScwoTgYyd6VU+XoHRUZby3TPJoJzMI0RT9awhojHcrF+1kcBUI
         g/eREvbEEiG3nMyrhFzhkrD48NqwQq3W3swtI+UIABJYsSsGy95hy8dBnGSHL9/Hsh9P
         0e/2e12oL0mUZdMbizR1enY8R65yRFeeazR8nJAId80lvkHRD8aeleH7CN4gXx4Spdwk
         ErPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731610; x=1705336410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+fG5v+imY2py3wbXbsm/HP6trxiLASLFZtD6HV2z7k=;
        b=t+VETuoCacYnzYd/+JQWLrJ3RlZ2qDY+OL3G7zUX+y4VwrMj2bq8mUS1wMNsLTtnBB
         4P6s8+H8DyWYWyBhvXDHQXhI3nyEmJNOV3U0zbFyqzlSWZPJC8Rt1q+xoeJge4rvwuLE
         SNHlPP9EbQZ+pl0NzhIrSiel6sl1DRQB9ixdORQEFH8oEeQU8iSqCFskhyAW2OGNeO99
         vjvhkQoKPCxsw2VkHYGCMo73qPKGgVvenpt1H9HZl+pLVelW6P6vTB1IFz0IM8i1016B
         gsZ8CrzOjzAV5rtyASl3xQVFy/L9wvqQrVD/T9VEAu3nixmZ+WeVJUvv/efJlGup2rFD
         YbXw==
X-Gm-Message-State: AOJu0Yyv+0ZRJ9OY8Pg1vlyY/X6AIC4Wbuh3ucmnSfYQRu4ZjgC5QMZB
	405/x/9Rpmu7mRh3L7kDdwT7VkuGNws/yWIpbt8dfKPlW9k=
X-Google-Smtp-Source: AGHT+IGptaavLwH1Dc9wotHLaERV7rmIKx8zwsAeWYcGLjGx5ZQLyvTyr/sBJpR5Y1q/a1+GCbCBqA==
X-Received: by 2002:a05:6122:2220:b0:4b7:1d58:49b8 with SMTP id bb32-20020a056122222000b004b71d5849b8mr1466875vkb.25.1704731609807;
        Mon, 08 Jan 2024 08:33:29 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id eq15-20020a056122398f00b004b7483f6a18sm24661vkb.6.2024.01.08.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 08:33:29 -0800 (PST)
Date: Mon, 8 Jan 2024 16:33:27 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] counter: stm32-timer-cnt: rename quadrature
 signal
Message-ID: <ZZwj10BnNjMUifPE@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-2-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rdmwjTK3ghE0dbDW"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-2-fabrice.gasnier@foss.st.com>


--rdmwjTK3ghE0dbDW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:17PM +0100, Fabrice Gasnier wrote:
> Drop the Quadrature convention in the signal name. On stm32-timer:
> - Quadrature A signal corresponds to timer input ch1, hence "Channel 1"
> - Quadrature B signal corresponds to timer input ch2, hence "Channel 2".
> So name these signals after their channel. I suspect it referred to the
> (unique) quadrature counter support earlier, but the physical input
> really is CH1/CH2. This will be easier to support other counter modes.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

--rdmwjTK3ghE0dbDW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwj1wAKCRC1SFbKvhIj
K9TLAP4lcFVt469l32BkPkqH/MtsvPu9cYickkeI10y/yKNoIwD/ZBIK1C6koq4C
SsQkop/uhdo6JxdLbMJnkDRzlwxqyAA=
=TSm1
-----END PGP SIGNATURE-----

--rdmwjTK3ghE0dbDW--

