Return-Path: <linux-iio+bounces-11724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0FE9B8541
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840F6281D21
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568F31AF4E9;
	Thu, 31 Oct 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlcKdQzf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0816DEBD;
	Thu, 31 Oct 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409997; cv=none; b=cyCp4tfvnHw0P4BYhPSBi9f5UO1gcqODf0jBPwMI1A08aVfLRTFy6fEchyfKzNB0eT4nStVl4Z+ElKPJeRR2Hr925DewT43kDMLN7j1M2ocNLhbm44/38I0uF33F41Kee4Wxfa9q1S3IPgNhHDhM2LuI4B2JLHoH0z/0Br0NUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409997; c=relaxed/simple;
	bh=VUzrvm/tYBA/5bAwUvD6nwsQCs04brxQF4rlYCrJQmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfLlDrfssGfDdCdRGRuKVWJBm+68Jld9BTa8mZAY5MvpJ3pelKpy7003iI4DHpf0wGkZ19wMv04uPLOL5qQ9AM3MROwKZHc2HauqG/BTH88D3KM0SO6v4y/GgFQ2huTSXW+CXI9On/5NiwAltT90p2eWuTOvUGhvv14OMDZlDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlcKdQzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729B3C4CEC3;
	Thu, 31 Oct 2024 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730409996;
	bh=VUzrvm/tYBA/5bAwUvD6nwsQCs04brxQF4rlYCrJQmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LlcKdQzfEw3ANX6Md4RVtTUoRCbB1Gvi9LlkVxWk6wKaV6B8fA0ObJG2+2qPmf8F1
	 vicor3fo541Gb5WNebFijltdSm1BATfAgWpRcKBYUuNsveDrNf8FE3zpB7J6+MPwnl
	 rHwZjL4ie8bbWCaO28ZznFen5fDklPfv3n8fbrhlGwd4VCUEsBNCY+7ZAEiAkPsHOE
	 vZbvxLhp3fxdHpoD5+M0f+9GQLiyVGVoTKrUQc5RAPKE1diZ6YwhkdAYaladDdi3Fs
	 cW+naEes8US07Ncg6E2NZhi++d0LSqt0Qjx49gSeO2n1cQQ0sgsnsdw300tX32O4BC
	 nHC2H2Pq8n1pA==
Date: Thu, 31 Oct 2024 21:26:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Angelo
 Dureghello <adureghello@baylibre.com>, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 0/8] iio: add support for the ad3552r AXI DAC IP
Message-ID: <20241031212626.64b30020@jic23-huawei>
In-Reply-To: <139a7fb4-124a-4d0e-b1a1-32f8d2fb65f2@baylibre.com>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
	<139a7fb4-124a-4d0e-b1a1-32f8d2fb65f2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 14:08:15 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/28/24 4:45 PM, Angelo Dureghello wrote:
> > Purpose is to add ad3552r AXI DAC (fpga-based) support.
> > 
> > The "ad3552r" AXI IP, a variant of the generic "DAC" AXI IP,
> > has been created to reach the maximum speed (33MUPS) supported
> > from the ad3552r. To obtain the maximum transfer rate, a custom
> > IP core module has been implemented with a QSPI interface with
> > DDR (Double Data Rate) mode.
> > 
> > The design is actually using the DAC backend since the register
> > map is the same of the generic DAC IP, except for some customized
> > bitfields. For this reason, a new "compatible" has been added
> > in adi-axi-dac.c.
> > 
> > Also, backend has been extended with all the needed functions
> > for this use case, keeping the names gneric.
> > 
> > The following patch is actually applying to linux-iio/testing.
> > 
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Series applied with 2 tweaks as called out in replies to individual
patches. Pushed out initially as testing for 0-day to see if there
are any issues my (admittedly now very lazy) build tests didn't find.

Thanks,

Jonathan

