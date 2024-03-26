Return-Path: <linux-iio+bounces-3809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064588BD0D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 10:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A5D1F3C48C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379A1BF3B;
	Tue, 26 Mar 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="JMrkR3Yu"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDE182AE;
	Tue, 26 Mar 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443649; cv=none; b=OOml/jmYkjEtLg+Pj/4RXyU0+MWhI6BI/NJe0E5+iOX3dqu6CCjSb8JIzNNRTss7KVNvCpBc45OwTSgR0kZFb5KKrqZy92TMY8aGZbuYFqyxX/zK1Nr1Oz/oD1ZgRnDajJeXtKNHGLzFLvujQHXbPf2scFU6060JSkE84PpFLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443649; c=relaxed/simple;
	bh=+wd5QAkdUVK72DSv5q0YcoVlXQfUUb7wMpvwf+pMKjM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EH8eRPMD3OoH3uNOlITdY1DVL/cl39UwkqAMvkyzbdILQGi9XwOwqOuHZBpRXcM8psvScBWgJlyII6ffgqqttK0X37bCZkpwAgn6OUibPakQG8BB1RuQ5Qe5tbRWAmapYmvnWR+M8bscxiXx9jrqyVNfO2z7iFojTQr8UwxKdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=JMrkR3Yu; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nqsIzUYe4Uyqg7s5Qh9gOSV7VZcuT7RC17INw0URvwA=;
	b=JMrkR3YuYGk2PvNygRJJI4F+b9l19kd33Q+6fNNGkP+xH1WbH8KFFvveBOglLgqKA2PxHXjTaYu
	jlQRix5IKkRfF3LS/r9vbM4RJ4yQiQViWYQF9SfR6yHXdwvaSB9SM2P3+j0f/NLIiszPhnTKEmMTV
	i5ZZxPRqjlzcUa3GMiyyGX5DJvnWcZi0iC+KIWHjyXRlRhx3kZrsQ4vgSkUiF3J9t8r8B48a1guvG
	GnX/EYFhEKTJYpLVnKWLuSvIhqh93b3yuuQCb5WLHdVKsXm/t5hO6Q7TvEtRnIyCOMuIL+nl5JW95
	kcXdQkcLYYjeLEpgrSQoDEvRelKXkJli6LZA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1rp2fl-0009W7-9W; Tue, 26 Mar 2024 10:00:45 +0100
Received: from [185.17.218.86] (helo=smtpclient.apple)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1rp2fk-000DcW-1h;
	Tue, 26 Mar 2024 10:00:44 +0100
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 1/5] dt-bindings: iio: dac: ti,dac5571: Add DAC081C081
 support
From: Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Mar 2024 10:00:34 +0100
Cc: devicetree@vger.kernel.org,
 imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Trevor Zaharichuk <trevor@au-zone.com>,
 Greg Lytle <greg@au-zone.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <95E1531C-EC87-4565-AF92-398B9125881F@geanix.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
 <20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: Apple Mail (2.3774.400.31)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27225/Mon Mar 25 09:30:27 2024)



> On 25 Mar 2024, at 21.32, Laurent Pinchart =
<laurent.pinchart@ideasonboard.com> wrote:
>=20
> The DAC081C081 is a TI DAC whose software interface is compatible with
> the DAC5571. It is the 8-bit version of the DAC121C081, already
> supported by the DAC5571 bindings. Extends the bindings to support =
this
> chip.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml =
b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> index 79da0323c327..e59db861e2eb 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> @@ -21,6 +21,7 @@ properties:
>       - ti,dac5573
>       - ti,dac6573
>       - ti,dac7573
> +      - ti,dac081c081
>       - ti,dac121c081
>=20
>   reg:
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20



