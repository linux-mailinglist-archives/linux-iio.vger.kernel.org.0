Return-Path: <linux-iio+bounces-396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158837F93F5
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F592281221
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF92AD2F8;
	Sun, 26 Nov 2023 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqRejtF/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E481368;
	Sun, 26 Nov 2023 16:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BA7C433C7;
	Sun, 26 Nov 2023 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701016772;
	bh=zAX6XnqcADpFRg2WH300zCg5ZPXSwswAQpyCMx/ybWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cqRejtF/XVGxW3ad/CblOp6VNbmmKTOv05rUG9ceK4nBSLOxBRk5nkqwfq+2csAVH
	 Gn2rOkqZ8chuvKWUn0DNPZbVqz9A3RVQ3hiiCTsK15myabedk2MTdrVlWZDsznXHnE
	 CrBpdiWZYh8BeHnQEgyurCbpL9TcftcTkig0B9J7TgmgdKuCME68TV6uqFpi3+X66F
	 qJ29734WLRJ0zyBMDhTLSW/FmK3vH7oFIW7ZPDuOpvV+11bSDXlQ469DYoxmz90C5d
	 8p5X3+4ja8o7YhqzpIAObJLMWWOA0kpM1bKi1nKObQQBn5NK4KZWGm2yCTs/boVBb5
	 UuzkeflWTG0HQ==
Date: Sun, 26 Nov 2023 16:39:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Ana-Maria Cusco <anamaria.cuscoo@gmail.com>, Ana-Maria Cusco
 <ana-maria.cusco@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: hmc425a: add entry for
 ADRF5740 Attenuator
Message-ID: <20231126163922.74505322@jic23-huawei>
In-Reply-To: <20231113-left-patchwork-09a1f88b0fa2@squawk>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
	<20231113102535.51074-3-anamaria.cuscoo@gmail.com>
	<20231113-discourse-sushi-e8fea2450a44@squawk>
	<20231113-left-patchwork-09a1f88b0fa2@squawk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 13:41:27 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Nov 13, 2023 at 01:40:40PM +0000, Conor Dooley wrote:
> > On Mon, Nov 13, 2023 at 12:25:35PM +0200, Ana-Maria Cusco wrote:  
> > > From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > > 
> > > The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
> > > attenuation control range in 2 dB steps.
> > > 
> > > Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>  
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>  
> 
> One thing though, the bindings patch should come before the driver patch
> in your series.
Flipped order whilst applying.

Applied to the togreg branch of iio.git an pushed out initially as
testing for 0-day to poke at it and see if it can find anythign we missed.

Trivial thing but Ana-Maria, I'd prefer a cover letter even on a short series
like this. It provides a place for general comments / discussion / tags to be
applied and it gives it a pretty name in patchwork.

Jonathan


> 
> Thanks,
> conor.


