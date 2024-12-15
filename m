Return-Path: <linux-iio+bounces-13496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377619F2405
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 14:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5291651B3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB0186E46;
	Sun, 15 Dec 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gORSLekJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93588433A0;
	Sun, 15 Dec 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734267802; cv=none; b=Ho1MKRGfkW++frSc2yiu9/27fdOudPU6X6cQhg06+cPkfj/u6najBO78CEXqN6A581mD2VkZ8Hkes2fqBnpu0QmhgD2nAzOQtWGoZNgoD4AhLZbPB0WQppyFal01NfDZF3TBf+N+4QxmLtpsxVx4A7ukqw4KqrQP51a/hJAT/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734267802; c=relaxed/simple;
	bh=Q9HajXSiTCc5sizdjij01Tf6NtsXD1bcgnwfrfY4nsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHLNs6YvzPkXiZy4CGvKE/RsUCCOz+KeOTSAHXH1FAnDIijq9h6hFnw5F/cT8TdnnI4oExj91h5kh7B15kUQ92/VccXw2Z8c3m4sIm0b1O1Lm4xHPP0XiK3e8pDNKx6CPZ/CydNEoshgLGIO8Zx6bXxUJ8R4hIPEuiHsomo9xYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gORSLekJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C29C4CECE;
	Sun, 15 Dec 2024 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734267802;
	bh=Q9HajXSiTCc5sizdjij01Tf6NtsXD1bcgnwfrfY4nsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gORSLekJ3ZkyDoZplkfThnLqMkDXrymO9rEdQoNwDLw+OEY0BgJvdlLRGwCAqDDc0
	 EfzOnDbc0Asps3VEBjE47/RvaxMW3tgsYAEuL2VrA8265O6yzRaCrNvJrmtLASYjqx
	 vMttMj8/tTFRBxz84rK2Aru2j/4BFpH3mlMJofSY2G0BzxH7i8aSZ+RIDw6ETHnS03
	 E3gP4q/qiFTKuJFRFVorSflMZarVYqEXjPwh/kWXgYKImKzTrSrsFg6lmNWs3CGn/E
	 Ugg9CQgDK42VAaZgE0J0/+cHS22AORyz/MXg+cKYSpdl4J+zAi0G7hJxCJqlEqy1Ma
	 JRslGr+OWIBYw==
Date: Sun, 15 Dec 2024 13:03:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: ahaslam@baylibre.com, krzk+dt@kernel.org, dlechner@baylibre.com,
 Michael.Hennerich@analog.com, robh@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: ad5791: ldac gpio is active low
Message-ID: <20241215130313.781aebb7@jic23-huawei>
In-Reply-To: <20241106-tableful-outdoors-298ad815a107@spud>
References: <20241106103824.579292-1-ahaslam@baylibre.com>
	<20241106-tableful-outdoors-298ad815a107@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 15:47:01 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Nov 06, 2024 at 11:38:24AM +0100, ahaslam@baylibre.com wrote:
> > From: Axel Haslam <ahaslam@baylibre.com>
> > 
> > On the example, the ldac gpio is flagged as active high, when in reality
> > its an active low gpio. Fix the example by using the active low flag for
> > the ldac gpio.
> > 
> > Fixes: baaa92d284d5 ("dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios")
> > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>


Applied thanks.  I'd dropped the ball on this one, so only noticed when reviewing
the older stuff in patchwork for dependencies that had resolved.

Jonathan

