Return-Path: <linux-iio+bounces-15815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56091A3CD46
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 00:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AF2176E69
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 23:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807525A2B0;
	Wed, 19 Feb 2025 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBi0WTAN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B61DE3AC;
	Wed, 19 Feb 2025 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007065; cv=none; b=K/udneWfeHUBxNvELnFEfYDfHSYq925+NZEPr2BzusiDGeRHEpB6ZiEvSgp+leQhz0ONgwAbmi66dy+dfVx2lhT7MXRqBGslSPrtg4gbXdCjg/+NNKGFBEgXxEYSS9s5bWFwu+5jzGLdF9noSDFbb7TwJTae6GnIXn9dL/FiRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007065; c=relaxed/simple;
	bh=/sR/RM/+9K4Puu5LwxqGwGFVRF6ohXpNAUKGy0AUT3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sESF/xesW0VH7mHyicZSOzpjgGKsWC+imfDKIa3G6AKdw/7PMYfTPDiR4nUDyFawtsDc6oHF/iC7QEBrl5pjrMjf0855yE4lSOnTPnOJSuvHhckHOZJLNqm/WC6DG+gr6oN9ECusEsEGM8uCjx6Ws2QrRtCiGvNNzzLpcYZToeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBi0WTAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE613C4CEE0;
	Wed, 19 Feb 2025 23:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740007064;
	bh=/sR/RM/+9K4Puu5LwxqGwGFVRF6ohXpNAUKGy0AUT3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBi0WTANtCHuQ+gNr0a+re90u3Y96eAtgAWJdl7LxDfiPppK/YHz1IF9q10hBXFOc
	 2azg60d0TO6kwQoBrsns3412AY8r4RGMlFXgd9sMYRzqeGqbgO/vs5nniipuO/l5Qo
	 xWicTptktSySQ6xA6k/ceex9rUmkA1q9kbesObak4WLlOOgk5f/06eL7K+OSASPOYu
	 F1S8iTMpISBpEEHBFt3rBMKyPiVf/xCZqRNVw3WgGT0GrcMLdcUqTGZKxXNtmCJ1hn
	 Lr/2Zg+Fyi0+mEY4zmmBKydLeEfiAQwUtctNuI7pMEPJLqGtrFuWh/bcFyGgzEqYrx
	 5g8VN1JlJiENQ==
Date: Wed, 19 Feb 2025 17:17:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RESEND PATCH v8 4/6] dt-bindings: iio: Add adis16550 bindings
Message-ID: <174000706255.3157600.13765807090246524556.robh@kernel.org>
References: <20250217105753.605465-1-robert.budai@analog.com>
 <20250217105753.605465-5-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217105753.605465-5-robert.budai@analog.com>


On Mon, 17 Feb 2025 12:57:48 +0200, Robert Budai wrote:
> Document the ADIS16550 device devicetree bindings.
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
> 
> v8:
> - added extra blank lines
> - changes reset-gpios description according to suggested changes
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       | 74 +++++++++++++++++++
>  MAINTAINERS                                   | 10 +++
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


