Return-Path: <linux-iio+bounces-17984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471DA86874
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 23:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783F91B6403C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 21:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612DD29CB3D;
	Fri, 11 Apr 2025 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu+EtA0L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F16270ED8;
	Fri, 11 Apr 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407810; cv=none; b=Tct7mh6exZyUwg/phNCluL1fzbVIcZzzrGLQ9T+L0A3K1bJwkGpq5kV+gfBXxmZ98Sonht8rvtZSCfWhekYRctMFfQzXEKSDNXYEYFBPDQzIre3tuXuc1SG80h0Pln0lUyVOzjMU37qEDLNjqj+hlqmWVFyE7WVQWy6w7ewJQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407810; c=relaxed/simple;
	bh=+l7x6W8iz89x+DPyZg2u2mQyc3VfzJXcRgchJEMpNug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1TPBZbJdbfHditAG1HvammogEDXDx7wm959AdbL3Z+mR1jrFeWjkofheIhd1TSM/7Bi0690QQ3Fc30hux25JXyWqfOlNeSiNB47VUfKWIiKUUBYhT/KO+HIZ0D5MG4X6lB3ducvrY0gvM2z3JytR/Js5GswYwp17KBszYsgLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu+EtA0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386A9C4CEE5;
	Fri, 11 Apr 2025 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744407809;
	bh=+l7x6W8iz89x+DPyZg2u2mQyc3VfzJXcRgchJEMpNug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu+EtA0LtCen+cKaHZ2+b0T4ZR2XYb72kKc0I7LQhngDtqP4itUuXukZqZ4b1Us/L
	 M1pvKoJ6B2nhvwEtqZ6gJmU4ydkN4Z/PqEfLb43JokMvzi4D0sElAR/0iA5KgXC+wX
	 DTmfJwJxtkN2NY4CaNhYXgyeZcCQahlVgZ1sqLqGPgQsKulI7AVZYvbPA3VpmVmw7Q
	 XWdgpRL8BeIFQsHFOZSdUY9Nv6S/VpAN5Vk/0nCXbBURAPtBQIVnz8cRQvxdbnCJz5
	 sDjr8tq+pQdFE3p5CPnxcf2MAkKw4r09YJ6SN9PT7zMWCcjRRgBXkGY3hER6t9mtOe
	 WgEoZ3UVm9HBA==
Date: Fri, 11 Apr 2025 16:43:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: linux-iio@vger.kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 12/13] dt-bindings: iio: adc: add ad4080
Message-ID: <174440780757.4138182.8221415333570866492.robh@kernel.org>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
 <20250411123627.6114-13-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411123627.6114-13-antoniu.miclaus@analog.com>


On Fri, 11 Apr 2025 15:36:26 +0300, Antoniu Miclaus wrote:
> Add devicetree bindings for ad4080 family.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - add descripton for spi bus
>  - use actual pin for clock name
>  - fix typo in num lanes description
>  - add iio-backends
>  - don't make all supplies mandatory
>  .../bindings/iio/adc/adi,ad4080.yaml          | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


