Return-Path: <linux-iio+bounces-599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342D803A1D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 17:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13891F20D38
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1E2DF87;
	Mon,  4 Dec 2023 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDXIdZK0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6695;
	Mon,  4 Dec 2023 08:24:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so13160825e9.1;
        Mon, 04 Dec 2023 08:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701707051; x=1702311851; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bURge2vt79VRneDabsklLqiEz0N2z8OoWoSIppVQtJw=;
        b=kDXIdZK0Dh8GSEdjly5Jo1bTDsnE4S9ah99w35tguFTXqWo0wLfksPQWXGa5Tfx0t3
         oFYzlzmJXc0O/zPqI8qLBRyvi9spG8VysD61QnypgI85MedhUjbg1SqbdISl6T/qG8gd
         d2BkXotFTov3nkriKgkeIauID/hTxM9c0BhzOBz8DOI7ESPNM3c0m1VuGmRoVcA4SC3l
         h1DUdZnPiXSTt7LO3OTwE/3gBAiUqe+4QXt0pYjt/W7N0JtPMGkBMcSwY3BbnyiSUjyW
         j/3fhvwsKmBo5DPsr/QgO5Haz02m97ciXghyZO6povwFGr5JCQFUTR29hjjCqoAMduso
         G5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707051; x=1702311851;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bURge2vt79VRneDabsklLqiEz0N2z8OoWoSIppVQtJw=;
        b=tawFnNxUBpR8g25HXaxgUwXnlxhuFaoHzou7EG/ty9a210SUXLL1dQPhSZa9scEm0T
         vJOr21LIev/sGUkRHB49CdyruibV5dlPxdmQywEHBXtT1nEVisawmM56Ont6zQ/T7bJK
         GVOQf2bAZRbDKa/J0tGjDrkF8E2SYflo0GrUIffNXDA8YogCe9IB6ZEqH6bBwoMHOkmV
         QNF4M1wPCjjGN58gfKc8P/azr6uCcqBJE5FwWCvkf3YraogNx4idRIuJcXYhS7pIi7+X
         xFXHq65cJUFwrKffRONUDH6TLXf4zVQpARqhLTSxGTeFbkDuLmSpE1mLXSpUn+xSbTxI
         LDoA==
X-Gm-Message-State: AOJu0Yw8MpUpdpnP4LA69osEtJfnBho+l9jNbGSAlBwlnXca+BMiLmfk
	Hf2yi2jIfdY1nI8gE32LRc8=
X-Google-Smtp-Source: AGHT+IEIh+vWJmOC9e0jLqvTTay900PsVYzAj9Of0MHvDqWbHGkk45DT9il4h204XGLi7Suhw8Zqkw==
X-Received: by 2002:a05:600c:4506:b0:40b:37ef:3671 with SMTP id t6-20020a05600c450600b0040b37ef3671mr3777346wmo.38.1701707050827;
        Mon, 04 Dec 2023 08:24:10 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id i18-20020adfefd2000000b003334a1e92dasm3069964wrp.70.2023.12.04.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:24:10 -0800 (PST)
Message-ID: <0a3b6fc8393a8a07a7ff2359380c25ff42fffcf7.camel@gmail.com>
Subject: Re: [PATCH 09/12] iio: adc: ad9467: use chip_info variables instead
 of array
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Date: Mon, 04 Dec 2023 17:24:10 +0100
In-Reply-To: <20231204152533.252b6bfa@jic23-huawei>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	 <20231121-dev-iio-backend-v1-9-6a3d542eba35@analog.com>
	 <20231204152533.252b6bfa@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 15:25 +0000, Jonathan Cameron wrote:
> On Tue, 21 Nov 2023 11:20:22 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Instead of having an array and keeping IDs for each entry of the array,
> > just have a chip_info struct per device.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Hi Nuno,
>=20
> Probably makes sense to break out the various tidy up an fixes for ad9467=
 as a
> precursor series and just refer to it from the main one (which will proba=
bly take
> longer to settle).=C2=A0 Hopefully we can get these out the way and remov=
e the
> distraction
> from the stuff you really care about!
>=20
> Jonathan

Alright... will do that!=20

- Nuno S=C3=A1

