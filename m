Return-Path: <linux-iio+bounces-24322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29272B8C722
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AD81BC4F05
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0912FCBFF;
	Sat, 20 Sep 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR8GvtQY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F48A27816E;
	Sat, 20 Sep 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758369371; cv=none; b=A8jnbh5DBFcbd9c2ZByS2tgKlz+yBbE8lc+jMLQtd+OLZTm5UE+OjerTmhxEi3/m6Ny+516c9pIrLRpDCVGc1Lp0Tp//eKb1yfitFNehxata1OykR72rPi4Uhu1CwS2Ytw8LEmRILbKm5U9qzqjLp0rv/i33It3lKuQuJbsxcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758369371; c=relaxed/simple;
	bh=ZXLh31mP5xc2BT8qYKn3o6B80+tmZbxITaHjZZwPsCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyjC6kw/tC9rMAICX134au6WbZ/gE+RRPlJWohSLywkVaDdjGgk8X7pKU+Vun7yxKy188EIbocenq9WRQJlpwYVfohEFpQ5NwqbRiWmNQ2rS6SHOZ4T+1w8UTxNFayQ3s2YdIkRGlHEM/SSYPyRa6WnTPoHVLGl8qWQh8mDMsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR8GvtQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ADCC4CEEB;
	Sat, 20 Sep 2025 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758369370;
	bh=ZXLh31mP5xc2BT8qYKn3o6B80+tmZbxITaHjZZwPsCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tR8GvtQY7FWsWhPgzAyt4RxpQD6MAcS69RiJoo2xthh281uC+e4SSLs6cLEeFaLCp
	 EayWdSGjIPfOYSBq1nhclvDCSDxHkLYFsdWAlZq0j7DDgH3Qe7hfliXSBtru71vCd0
	 WTC4nwq5G3d8rn0BSJiBBbxyxiPr+HFHz/dwGevYBZxOYTlhtmp+C4ZebNgXMjZZPw
	 6JwWA5Hq0had6BJRaNb4CIpzc4GLK2+IOyKEQZ6R2PQ0J0tJDAMQC6muidxWWRBgS/
	 ClUnf8ronfsgfwyxtRWnCVpsF7ir9X+GjHjkO9Bge+dGvPVRW3VGNOTG9Lbjqpv0gP
	 jWiD3CUouZo9w==
Date: Sat, 20 Sep 2025 12:56:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: add processed write API
Message-ID: <20250920125600.182971d9@jic23-huawei>
In-Reply-To: <2893324.mvXUDI8C0e@fw-rgant>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
	<20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
	<decdb75c-b61e-4e0f-bddd-cfc8986f3b6f@baylibre.com>
	<2893324.mvXUDI8C0e@fw-rgant>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 17:46:00 +0200
Romain Gantois <romain.gantois@bootlin.com> wrote:

> Hello David,
> 
> On Tuesday, 16 September 2025 21:23:04 CEST David Lechner wrote:
> > On 9/16/25 5:24 AM, Romain Gantois wrote:  
> > > Add a function to allow IIO consumers to write a processed value to a  
> ...
> > > +		case IIO_VAL_FRACTIONAL:
> > > +			tmp_num = (s64)processed * (s64)scale_val2;
> > > +			tmp_den = scale_val;
> > > +			break;
> > > +		case IIO_VAL_FRACTIONAL_LOG2:
> > > +			tmp_num = (s64)processed << scale_val2;
> > > +			tmp_den = scale_val;
> > > +			break;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		tmp_den *= scale;
> > > +
> > > +		*raw = div64_s64(tmp_num, tmp_den);
> > > +	}  
> > 
> > It can be quite tricky to get all of these combinations right. I would
> > prefer if added some unit tests like we did in [1].
> > 
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=tes
> > ting&id=c732e60ee10ed0611a59513cbf9c8d35fbe7cf65  
> 
> Agreed, that would be nice, I'll look into it.
> 
> Thanks,
> 

Overall code looks fine to me but unit tests would indeed be great.
Thanks,

Jonathan

