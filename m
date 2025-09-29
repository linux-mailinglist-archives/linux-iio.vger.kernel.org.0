Return-Path: <linux-iio+bounces-24566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D1BA9EFB
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC393B6CB3
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750230C0E2;
	Mon, 29 Sep 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IFdjSM8P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21111B87C0;
	Mon, 29 Sep 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161894; cv=none; b=p+Ui0mwaMoX9yo2DkaUWuE4t1gwoOdXm4FxFoYitAVq+HEUk5Wr/tebTuGx1YKDATaH/Ay01RrLJQ1QwqGZ9VZGBtt8gPAtymL8gja0ZcXIkjXhsxHxFe/CTn+aNDEwtcI5ftWa1DT+/69rUiV67/BR5WyPfW8dvNquOBdw9wpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161894; c=relaxed/simple;
	bh=6K6xnMzg6H0rJ1/Ys5KhM8cvsEqih0X00Quwze+pSpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Al5jIdBTtkmFKN4UtYADLEP0Hj/Oqnf0xCOVbLAGmpVowkH51Azlc/mHqVNnRs53SJcCALfaM2z2P8qJNFZ4Y+D3kgQxn/TwJ7L8sn6eu1DfpgQSiTJYh6rbRNlui4AAhoYrdSNHXIKEA1X0Z1hkeEFCmir6CaQpaVAaIDFIxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IFdjSM8P; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87C1EC02449;
	Mon, 29 Sep 2025 16:04:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 34192606AE;
	Mon, 29 Sep 2025 16:04:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5337C102F1892;
	Mon, 29 Sep 2025 18:04:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759161889; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7a7GtGpo5X1l9P3GKhsuPNB4IdunnxAGumvvi4gFkU8=;
	b=IFdjSM8P98TJ647WzjSZ0INP7ROVt/cFJRjnRpoupp21cigmNYclzd1f+V90eX9Rw4AcrA
	H7bf0hNKucf7KwbDU8luAP4qZk1HSS/pwpdnv09Kb5fbq/hO9NZPyGtk4DnZjxm9KJ/aq8
	Z3ERVub5+DNVuvHQFR2/bFHBCA75qVEqJuuqWGqtikNXhsD+s8KMRjMPd7R9HycuVVQtI7
	acxueVvM+LLewj8GIpoicofTHkdhuT0D5Hl94QAhiVQU/H6XLrA/SaKmJ4nS3cRE9As1Xa
	Q5k74nACZPO2l13uqMuW2NF/LtTcFSwcXB3tvqmsxBlFbcrp37lXWLPy49zeYQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,  Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  Andy Shevchenko <andy@kernel.org>,
  linux-i3c@lists.infradead.org,  linux-kernel@vger.kernel.org,
  imx@lists.linux.dev,  linux-iio@vger.kernel.org,  Carlos Song
 <carlos.song@nxp.com>
Subject: Re: [PATCH v2 2/4] i3c: master: svc: Add basic HDR mode support
In-Reply-To: <aNqr8+ehPehq41gw@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Mon, 29 Sep 2025 11:55:31 -0400")
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
	<20250924-i3c_ddr-v2-2-682a0eb32572@nxp.com>
	<87seg5i810.fsf@bootlin.com>
	<aNqr8+ehPehq41gw@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 29 Sep 2025 18:04:46 +0200
Message-ID: <873485i6sh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 29/09/2025 at 11:55:31 -04, Frank Li <Frank.li@nxp.com> wrote:

> On Mon, Sep 29, 2025 at 05:38:03PM +0200, Miquel Raynal wrote:
>> Hi Frank,
>>
> ...
>
>> > @@ -1858,7 +1913,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
>> >  	.do_daa = svc_i3c_master_do_daa,
>> >  	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
>> >  	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
>> > -	.priv_xfers = svc_i3c_master_priv_xfers,
>> > +	.i3c_xfers = svc_i3c_master_i3c_xfers,
>>
>> Didn't you change this name in patch 1? If you kept both naming, it's
>> fine, otherwise you must do the switch in patch 1 as well to make sure
>> you don't break the build in the middle of the series.
>
> We keep both API for while. After first patch apply, I change all drivers
> to i3c_xfers, then remove old .priv_xfers.

Fine. Maybe mark it deprecated with a comment in the core? (I haven't
checked).

