Return-Path: <linux-iio+bounces-13382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D269EE0E3
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 09:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DC61889F94
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C320CCEC;
	Thu, 12 Dec 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I65s+1dw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9020CCD5;
	Thu, 12 Dec 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990906; cv=none; b=hu5+T+Lrj4o1RyUJtMziZmsZx7n1GWARVYQnFg+EhGzIqsDxSuUIsYlCR70oLtS5DelqoIBTTpBkXpMZkCBG2La/Vv8CiT8McrlUkqj+ULN8JtNW+xEvaByvoHFVr8JOLHygLxVmXq8P92gZhFqOGZn1jrbIm1Dc64InjGffXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990906; c=relaxed/simple;
	bh=iTu94tkLBfASIn9nPAb8LQ8+jAIiVJzN8RQ4ZD7V5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHl8mPXOXRCdZBRUZfCqlJ7jLvs3mj5jPgy70A0lkRP+zAbsutuBPAG5KmDxjBI0HlvmsSAXctRRANguAOEiZXBatjHXbVsVMAEOMxEzjPspFSlkrXdQJgWFtwd19bEMZ/Qld+xpKJBjGOnUXJLKwQOSpnXLBe2QpzFuRaOoSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I65s+1dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF29C4CECE;
	Thu, 12 Dec 2024 08:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733990906;
	bh=iTu94tkLBfASIn9nPAb8LQ8+jAIiVJzN8RQ4ZD7V5TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I65s+1dwNpNXqzgKqmOMajGKlPo0TJqt6k7A4edklgjbpfuCHCSCLmN54yiQrHcJ/
	 Wj7I/Qg9Pnaw0IS16fp5ivx4ldDPpsqsPBx0BJ1gdeM8USWmJVgAOX/bzhkkK6ne8M
	 FrTsXRQZmsCAfZiFv7DXCnTrRZOIInx2impLfNWQDYB1c8f+HnaKiYir9GsnFjTApc
	 P9YCflyQDpFD6mliar7ub2vKujb7bu2UjKxMc9m0NHY59/mAFdEkJD6k/vh0jT77fq
	 vAYGMoAKT/Z6qT77BLQ6YZpA2qUX10kLqd3V92PAkubmdsrcsrYheyuL64Tv19/gLN
	 +01B6TXg6KMtA==
Date: Thu, 12 Dec 2024 09:08:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eraretuya@gmail.com
Subject: Re: [PATCH v6 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <scybtk2qyy6m55klkj6tsv2snmcqp2zjbkzwfh5dv2p6cjjeud@xjq4vsxjszex>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
 <20241211230648.205806-4-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211230648.205806-4-l.rubusch@gmail.com>

On Wed, Dec 11, 2024 at 11:06:44PM +0000, Lothar Rubusch wrote:
> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor. Only one line will be connected for incoming events. The driver
> needs to be configured accordingly. If no interrupt line is set up, the
> sensor will fall back to FIFO bypass mode and still measure, but no
> interrupt based events are possible.

There was interrupt before and it was required, so I do not understand
last statement. You describe case which is impossible.

Best regards,
Krzysztof


