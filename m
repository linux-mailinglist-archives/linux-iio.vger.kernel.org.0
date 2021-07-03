Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5533BA98B
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhGCQqE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCQqE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 12:46:04 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52EC061762;
        Sat,  3 Jul 2021 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HtKfSB56fn7n+CnIV4JeUmzMser9oQjWjl30ggovg5A=; b=d6RvvMrj73CX7GlivJEj6YFc1s
        5wHerC+/gsLvZqsgWS1AuhxNjmC5ROlo/MyxQ2L674l27v0pWhQO9//pXReVAhD1sMH2ChfQG/teV
        I1f9qarNz7mnTJyDSl2r8eoU8H/IHQk7yoUZyAnGtGMJF2T4uNyjwfGPzNgeUB6rfvaU=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lzijm-0000bJ-J3; Sat, 03 Jul 2021 18:43:26 +0200
Date:   Sat, 3 Jul 2021 18:43:25 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: ricoh,rn5t618: ADC related nodes
 and properties
Message-ID: <20210703184325.4ce09fc7@aktux>
In-Reply-To: <20210703170245.1d310342@jic23-huawei>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-2-andreas@kemnade.info>
        <20210703170245.1d310342@jic23-huawei>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 3 Jul 2021 17:02:45 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat,  3 Jul 2021 10:42:21 +0200
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > Add ADC related nodes and properties. This will allow to wire
> > up ADC channels to consumers, especially to measure input voltages
> > by the power subdevice.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../bindings/mfd/ricoh,rn5t618.yaml           | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > index 032a7fb0b4a7..185f87a14a54 100644
> > --- a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
> > @@ -73,6 +73,48 @@ properties:
> >      description: |
> >        See Documentation/devicetree/bindings/power/power-controller.txt
> >  
> > +  adc:
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - ricoh,rn5t618-adc
> > +          - ricoh,rc5t619-adc
> > +
> > +      "#io-channel-cells":
> > +        const: 1
> > +
> > +    additionalProperties: false
> > +
> > +    required:
> > +      - compatible
> > +      - "#io-channel-cells"  
> 
> Strictly required?  If not used below (where it is optional)
> then why do we require the ADC driver to provided the services?
> 
> I don't mind you leave it as it is though if you prefer - it doesn't
> do any harm!
> 
ok, it is not that strictly required.

Regards,
Andreas
