Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46D6AA9CC
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 14:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCDNGf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 08:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCDNGe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 08:06:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D71F90A;
        Sat,  4 Mar 2023 05:06:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5143C60C86;
        Sat,  4 Mar 2023 13:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95376C433EF;
        Sat,  4 Mar 2023 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677935188;
        bh=iyHnBfq+YU01KjUUDq2m/Dzzn4Wzyy8OkU5LZIgElR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=idB1cnWBbaj46Lf99TgMly55TpK7Issu/kLUy1Tk1UwJCqE1qVWDlW7dqcw8lFjRL
         o2NVwBCpDnu/tsx1uIlWo7oXJYpbDfWM88JWqvlfYxhlUwa/ZlkC3UW+kg8GJp6XxQ
         in9cPMp1/LPlp67+WagnbDSNfCCDHXZg7uA0a8tQlqfJ+s6i7I13s2GVSrcUU5d17y
         gsWS6PmOcz/ORCtBZuVLjh9KtX9Hku4g9oM1pBH721XnJv5KVfqA8o2WBa6+IeXJ6B
         Zw6GKmxiiaMLEnQ0IKnxtiPKBMf1mQaoP4NvkiabFTS+BMuUaF2BlZuTlcQcx9BAug
         qc4VOQgX937kg==
Date:   Sat, 4 Mar 2023 13:06:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF
 converter bindings
Message-ID: <20230304130625.2b5536d8@jic23-huawei>
In-Reply-To: <55efb99d-f84a-0df9-67fa-0bf5c1372a42@ahepp.dev>
References: <20230304004109.78659-1-andrew.hepp@ahepp.dev>
        <73aa71ad-4cde-09d6-1af8-774701e330cd@linaro.org>
        <55efb99d-f84a-0df9-67fa-0bf5c1372a42@ahepp.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 4 Mar 2023 04:36:49 -0800
Andrew Hepp <andrew.hepp@ahepp.dev> wrote:

> Hi Krzysztof,
>=20
> Appreciate the feedback! Snipping for brevity.
>=20
> On 3/4/23 3:20 AM, Krzysztof Kozlowski wrote:
>=20
> ...
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    minItems: 1
> >> +    maxItems: 6
> >> +
> >> +  interrupt-names:
> >> +    minItems: 1
> >> +    maxItems: 6
> >> +    items:
> >> +      enum: =20
> >=20
> > The interrupts should be usually strictly ordered and you allow any
> > combinations. Why?
> >=20
> > Why are they optional? =20
>=20
> The driver as currently written doesn=E2=80=99t support any interrupts. T=
he=20
> device does not require interrupts to function.
>=20
> This is the first dt-binding I=E2=80=99ve written, so it=E2=80=99s very p=
ossible that=20
> I=E2=80=99ve made a mistake, but I believe any combination of interrupts =
should=20
> be valid. Each of the interrupts listed represent an independent=20
> physical pin of the mcp960x chip. That pin might not be connected at=20
> all, so it seems to me that any combination of interrupts should be allow=
ed.
>=20
> MCP9600 and MCP9601 chips have four alert interrupts that trigger when=20
> temperature crosses a threshold (with configurable hysteresis). The=20
> MCP9601 adds short and open circuit detection interrupts.

This is a very common situation for sensors, hence the use of
interrupt-names to allow us to specify any subset.  A driver using
these will then need to cope with a random subset (of course it's allowed
to just not use any of them at all if only some are wired, or any other
policy the driver author wants to use).

Board designers love to save pins on their interrupt controller
so not wiring them all up is very common.

Jonathan

>=20
> >=20
> >  =20
> >> +        - open
> >> +        - short
> >> +        - alert1
> >> +        - alert2
> >> +        - alert3
> >> +        - alert4
> >> +
> >> +  thermocouple-type: =20
> ...
>=20
> Thanks,
> Andy

