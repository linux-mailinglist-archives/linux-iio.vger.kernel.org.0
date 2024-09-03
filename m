Return-Path: <linux-iio+bounces-9062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40319694A4
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 09:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686A91F23F9E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DCC1D6C71;
	Tue,  3 Sep 2024 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr/arqyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA21CE6EA;
	Tue,  3 Sep 2024 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347133; cv=none; b=PdKfi/M/7hmykyU+vaHRErImNrlTd41M5Gz0WDNUAyCQSmFzQlgOGuCPWNwADcQCDG7MeoH2OND+qRwUMewk7VVGacFor5lvFfnz9K+Ue5BHQtgNZRZTvJMODJpNQmYTXpZd266ws7kQxDGF+tCX7scNekOMkL1zA7gLcGp4Zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347133; c=relaxed/simple;
	bh=XgobwF8j1pd6lyIIAqDJIYHlE0ymWaDN0bpPjwRiSVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLINu1ijHjNnyFwerOBtGK6HStDsXXdTBlFjaCN2UVx12zHXrDYlON+v3yy//ma/O12RNqA4pMQqMlwU0PDZQM/NGKSfdv9DG6zB6vURGYA4tQHMWzGRSaJ+zMRj2prsve+4mLitbyFov2zG8aak7cm24Opn470DE0jPGi9JUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr/arqyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25B4C4CEC6;
	Tue,  3 Sep 2024 07:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725347132;
	bh=XgobwF8j1pd6lyIIAqDJIYHlE0ymWaDN0bpPjwRiSVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tr/arqyWnyGYET8E0UgldazWFHMwTbXD7jKL2y/kO8F/dI2veZMHhAgXhPcV8ESkb
	 FXZjcMPPaTUwU1kEWMVz9t/iqJ1GdpCuxKIzsDBXOOpK5ZfiDPiv7i0xThD/KCnofs
	 A3/d3xWTKNH+s3YM25DK57nATVdLcf/KbMEfo8X4uYEssTAOyhJGLQj7rc/6aaOhMV
	 P3QOrdtGEDEwZucRxF0QgkLejYcvSR48d/eGiZzgRgg4lhAie9HTKlkySJVn72iC+O
	 ru0up3jN4WcjDwUfAbSHkq/5YigusPRAwiysqqYac/mWeBPPjPIqn78W9rd1z+RfA0
	 iEdHyKOt8dd4A==
Date: Tue, 3 Sep 2024 09:05:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>, jic23@kernel.org, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org
Cc: pmeerw@pmeerw.net, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: temperature: tmp006: document
 interrupt
Message-ID: <siejrijvfrkyhmliamwk5kzw2qqdxrgjejn2fowayjhyfhyyfj@zk5jtl3uoizz>
References: <20240902125946.350635-1-apokusinski01@gmail.com>
 <20240902125946.350635-3-apokusinski01@gmail.com>
 <a4655147-94b0-4f13-a35c-4ca858ae1f74@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4655147-94b0-4f13-a35c-4ca858ae1f74@kernel.org>

On Mon, Sep 02, 2024 at 06:04:15PM +0200, Krzysztof Kozlowski wrote:
> On 02/09/2024 14:59, Antoni Pokusinski wrote:
> > Update the example with interrupt bindings and add "interrupts" property
> 
> But why? Commit msg should answer this question. E.g. because hardware
> has interrupts or any other hardware-related reason
> 

And please point me which pin on the diagram/schematics is the interrupt
pin.

Best regards,
Krzysztof


