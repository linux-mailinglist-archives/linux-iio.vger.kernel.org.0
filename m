Return-Path: <linux-iio+bounces-13446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F39F1E5E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBCF163A88
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D818FC8F;
	Sat, 14 Dec 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8agEhLG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC3154C00;
	Sat, 14 Dec 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734177420; cv=none; b=tcl4ZnZs0OIEmmblw3TUdCWA7S42cd3zPOYJkdB9CDCpYjhatkSuq+LgjsXKqMRObSHBzNrQ/z4KyuYbRL/KyqVmh8fZByJqMBHcXojtV5Xs/mZFGQgAeSp74igzunmvP55aUAY61Ez1aS5uS9wxlRLP18P1Rggn4eTD891XudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734177420; c=relaxed/simple;
	bh=e7CE8+w2lR9vnZnxyFZ5NV1YGU7f5fZ374lTWK4pq4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUfWJGHbfi8opZEAGoQZA2PTN/8YXBbBsh+vW9k7SEN6FqcG24vANu2PWROTOGKAI6pQBC0pbyZbAMQniICGv6g7AqejnMWcxTnioZWRmWMQqZVY3JFVpTgZiDEKAmb5PHezm2KeLdHTkMJyppRgV89DbKGSWrMESPlOY4JRKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8agEhLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88ADC4CED1;
	Sat, 14 Dec 2024 11:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734177420;
	bh=e7CE8+w2lR9vnZnxyFZ5NV1YGU7f5fZ374lTWK4pq4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L8agEhLGgacEP0x1BMvxbyriJg9sWE51pg4CB71o5iZa2DrL4VEeoOal9kIpY2aV0
	 XConY2DPuGw8ARUazMiySvi6q+rvrwar5rimRm/btXjFjfylPb5ozLH6mMcqrkda5E
	 Fq1ltx8UPWxoiZoCyzij/T4QL/zVtrHFeA6towiyfQrZGqzoM+G+iGTsUImXFqpxcd
	 2PaiHzsk/b+zjcWzEgGU1FBKJ5bSr2nxC7JZBBU5QRn0Gc7fPe6rA2jwTc9hWwqekg
	 /4Udk0aJUgH1ZRNBXibjiQImH7ZxZADcFlAjxDcZc8NPjgSGTfedYtCzFZVdEkICRz
	 KoCFFMBoMs4hA==
Date: Sat, 14 Dec 2024 11:56:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v6 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <20241214115650.2b3a7f83@jic23-huawei>
In-Reply-To: <scybtk2qyy6m55klkj6tsv2snmcqp2zjbkzwfh5dv2p6cjjeud@xjq4vsxjszex>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
	<20241211230648.205806-4-l.rubusch@gmail.com>
	<scybtk2qyy6m55klkj6tsv2snmcqp2zjbkzwfh5dv2p6cjjeud@xjq4vsxjszex>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 09:08:22 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Wed, Dec 11, 2024 at 11:06:44PM +0000, Lothar Rubusch wrote:
> > Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> > sensor. Only one line will be connected for incoming events. The driver
> > needs to be configured accordingly.
This is all driver info.  This patch description just needs to say something
like:
"
There are two interrupt lines that may be connected. As the device can
route each type of interrupt to one or other of those lines, interrupt-names
is necessary for two reasons.

- One interrupt line is connected, the device has to be configured to send
  interrupts to that line.
- Two interrupt lines connected.  The device can route all interrupts to 
  one line or elect to split them up.

If no interrupt lines are connected, device functionality may be restricted.
"

Note as below, the required interrupts entry should be removed in a precursor
patch.

> If no interrupt line is set up, the
> > sensor will fall back to FIFO bypass mode and still measure, but no
> > interrupt based events are possible.  
> 
> There was interrupt before and it was required, so I do not understand
> last statement. You describe case which is impossible.

Binding was wrong. Interrupt isn't required for quite a bit of the functionality.

I'd like to see an earlier patch removing that required entry and explaining
why rather than jumping into adding the new interrupt-names part without
resolving that.  Its a relaxation of constraints so probably no need to backport
that patch.

Jonathan


> 
> Best regards,
> Krzysztof
> 


