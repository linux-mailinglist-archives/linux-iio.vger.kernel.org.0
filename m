Return-Path: <linux-iio+bounces-5016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86A68C4733
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859FCB213FA
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E873D388;
	Mon, 13 May 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9pu40/X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4413A1BB;
	Mon, 13 May 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626352; cv=none; b=KEUeHCgGyk1yQQHtQqpjiVHTRLO+I1LDDHXKepr8L6Jf+JUcKcV87NtxpN0Tc244IpLDpqKcJNDS2mKjgnGre7MDeFMBXlnaQhjRg6xfN5HoXZS0GQLiuu49UlCkCHTiBXSscY5GaFAEBQxYK+EyJThf5zcVBHzRL0BQIXnNMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626352; c=relaxed/simple;
	bh=05U+W5pmxNog0nvyBVeGWLs3kpXZgW+KY9xytQos1LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROC3yB6ZI9RU78fumLOaJ89YVSsPDWXMZNiNCr9F0HLl1bij9f9sz8GRW9ZEIiZR50Fw1WdIpYhP+rAFtG7WY/5T0456L1YT/Lc4hts9+iXCtBaohlxbXg4U7SX86ZhLdRd2YEhzaSRfTYgCHDXnre1DbrXf26x8ni7OhpHavCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9pu40/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16043C4AF07;
	Mon, 13 May 2024 18:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715626352;
	bh=05U+W5pmxNog0nvyBVeGWLs3kpXZgW+KY9xytQos1LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9pu40/X2L00+tL1Y6G8riHl/vudTK9PI0q1Tm7mHQYFHxQzx1uuQNu/zaUS595Cy
	 OMTaPijUL//zZoaa7jNsOlZhEpTnHJnOtvcYgib+4DvhuH7nCbDhQXxvLa7DCJd+w6
	 Hmu5UtYXY2fvosm3zhIcJ6nSoQaqUs3tc81+U5o822dXFi8KYiPssysN2eg2HPmHk3
	 KQRroKtAMQ4faYw9hB9LSbdaO8Uy7HFm4noMA2095jXWtNzEZ/UnzXX9QFjbT8ujcW
	 Awwr/wHGjUTmCZ6mE29GOVNfd+JbcfMHeQAmEtwsrpAcUFPMXYnm+xgfA0EDQz/BWO
	 f9Gml1rNySfDg==
Date: Mon, 13 May 2024 13:52:31 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, jic23@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: dac: fix ad3552r gain parameter
 names
Message-ID: <20240513185231.GA2920495-robh@kernel.org>
References: <20240510141836.1624009-1-adureghello@baylibre.org>
 <20240510141836.1624009-3-adureghello@baylibre.org>
 <CAMknhBGU8bXg7obzyjzb7a4AUbjnw_0b+mqEAYJJekAK2CB-CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBGU8bXg7obzyjzb7a4AUbjnw_0b+mqEAYJJekAK2CB-CQ@mail.gmail.com>

On Fri, May 10, 2024 at 10:43:18AM -0500, David Lechner wrote:
> On Fri, May 10, 2024 at 9:19 AM Angelo Dureghello
> <adureghello@baylibre.com> wrote:
> >
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >
> > The adi,gain-scaling-p/n values are an inverted log2,
> > so initial naiming was set correct, but the driver uses just
> > adi,gain-scaling-p/n, so uniforming documentation, that seems
> > a less-risk fix for future rebases, and still conformant to datasheet.
> >
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > index 17442cdfbe27..9e3dbf890bfa 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > @@ -94,13 +94,13 @@ patternProperties:
> >              maximum: 511
> >              minimum: -511
> >
> > -          adi,gain-scaling-p-inv-log2:
> > -            description: GainP = 1 / ( 2 ^ adi,gain-scaling-p-inv-log2)
> > +          adi,gain-scaling-p:
> > +            description: GainP = 1 / ( 2 ^ adi,gain-scaling-p)
> >              $ref: /schemas/types.yaml#/definitions/uint32
> >              enum: [0, 1, 2, 3]
> >
> > -          adi,gain-scaling-n-inv-log2:
> > -            description: GainN = 1 / ( 2 ^ adi,gain-scaling-n-inv-log2)
> > +          adi,gain-scaling-n:
> > +            description: GainN = 1 / ( 2 ^ adi,gain-scaling-n)
> >              $ref: /schemas/types.yaml#/definitions/uint32
> >              enum: [0, 1, 2, 3]
> >
> > @@ -109,8 +109,8 @@ patternProperties:
> >
> >          required:
> >            - adi,gain-offset
> > -          - adi,gain-scaling-p-inv-log2
> > -          - adi,gain-scaling-n-inv-log2
> > +          - adi,gain-scaling-p
> > +          - adi,gain-scaling-n
> >            - adi,rfb-ohms
> >
> >      required:
> > @@ -214,8 +214,8 @@ examples:
> >                  reg = <1>;
> >                  custom-output-range-config {
> >                      adi,gain-offset = <5>;
> > -                    adi,gain-scaling-p-inv-log2 = <1>;
> > -                    adi,gain-scaling-n-inv-log2 = <2>;
> > +                    adi,gain-scaling-p = <1>;
> > +                    adi,gain-scaling-n = <2>;
> >                      adi,rfb-ohms = <1>;
> >                  };
> >              };
> > --
> > 2.45.0.rc1
> >
> >
> 
> The DT bindings are generally considered immutable. So unless we can
> prove that no one has ever put adi,gain-scaling-n-inv-log2 in a .dtb
> file, 

You can't ever prove that. 

> we probably need to fix this in the driver rather than in the
> bindings. (The driver can still handle adi,gain-scaling-p in the
> driver for backwards compatibility but the official binding should be
> what was already accepted in the .yaml file)

If we can reasonable assume that the Linux driver is the only consumer, 
there are no upstream dts users (in kernel or other opensource 
projects), and/or the property is somewhat recent, then that's good 
enough IMO.

Rob

