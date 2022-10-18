Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AF9602A8F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Oct 2022 13:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJRLyC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Oct 2022 07:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJRLyB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2022 07:54:01 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF65BBF05
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2022 04:53:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r19so9438238qtx.6
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2022 04:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk0jo8h+bFKZZlklplQl3c4m7akalQuwqDchYrGv+m0=;
        b=vizGrCCqg9RquslozbYx0axYr5kAXiYgqZalRmhoLNFRoinFMu2jkK7AqdvVoC+/fU
         Mq6x1snsy2T6ky0crXRLuFzSGKtvI6D6FhEU4WN2XjcIwNPPtJaQzr+J630meY9QxpNN
         NV68HQ7ofumTeJnP5Vvw9IMFM2ODAX1hCARtGUYvu73QQgf181+oOTrE3wBkkFNMUTNV
         Q8vd+WO+DIoLgDKsWw0e3oYbNDrjdc6NV8EbGw1IaQAN7ebt5MovBDIlrNu3/w3MzTIs
         YNnmIDfL15Jjphg1ToAIRcYR9LarivoIeqRfumpdAxrGvh60HgcMBsR1FoTHCPBQjzYj
         m2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk0jo8h+bFKZZlklplQl3c4m7akalQuwqDchYrGv+m0=;
        b=VGJ7MYpD4vC0CThoiosgovt3s99P0kze08KEoHifqVa3+k4yIQy/jHs3eixwou2zmS
         tpg769baiSP7MsIafr9lvW2CVP2u7dnT4VFo8aUU4Xbgo36wj8rZsl4vH8ltyiicDb26
         0n3WCFhHj14ERZiVJmiK0WDMFmG7XFk4kx9WzRqti8VhWLdi2tyqRbqCTVObrnFCwDg4
         PguheJQenQYP6VbIEkPdssR98X1df3omKZ9lZLLDen8FlZEdZGsqZIKLnhpaYU8gnyfj
         X7pA/vGw3V9LXYM4Nw/GxcY9+s4HjSrEdAw0+sJcgdtkF9BBzispg1WqXPyUyfLyDw16
         6ViA==
X-Gm-Message-State: ACrzQf2SjCAyW8GQtAH2of88mAouKr46nYaRpG7pHQDRVyQbAtvbeAw1
        zWOHauLy57YdzXIjuAE6UaPa1w==
X-Google-Smtp-Source: AMsMyM7TOGVWHULqQc1ZHTl5rnpC3Bf7tYz+BXWszc6yjpvbv81WnehjVeT5hwgn0edgY4jq8Tsw+A==
X-Received: by 2002:ac8:5814:0:b0:399:39ca:fd63 with SMTP id g20-20020ac85814000000b0039939cafd63mr1719677qtg.0.1666094039028;
        Tue, 18 Oct 2022 04:53:59 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006ec59941acasm2306305qko.11.2022.10.18.04.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 04:53:58 -0700 (PDT)
Date:   Tue, 18 Oct 2022 07:53:56 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Handle Signal1 read and
 Synapse
Message-ID: <Y06T1GPSO0ZgSOSs@fedora>
References: <20221017225404.67127-1-william.gray@linaro.org>
 <Y05gPzkIciwVuUdB@kb-xps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v/w0JJUH87vcSvz3"
Content-Disposition: inline
In-Reply-To: <Y05gPzkIciwVuUdB@kb-xps>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--v/w0JJUH87vcSvz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2022 at 10:13:51AM +0200, Kamel Bouhara wrote:
> On Mon, Oct 17, 2022 at 06:54:04PM -0400, William Breathitt Gray wrote:
> > The signal_read(), action_read(), and action_write() callbacks have been
> > assuming Signal0 is requested without checking. This results in requests
> > for Signal1 returning data for Signal0. This patch fixes these
> > oversights by properly checking for the Signal's id in the respective
> > callbacks and handling accordingly based on the particular Signal
> > requested. The trig_inverted member of the mchp_tc_data is removed as
> > superfluous.
> >
> > Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> > Cc: stable@kernel.org
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> Looks ok to me, thanks.
>=20
> Reviewed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

I'm going to submit a v2 of this patch for the sake of making it a tad
easier to backport and also simpler to handle if a lock is introduced at
a later point for this driver.

William Breathitt Gray

--v/w0JJUH87vcSvz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY06T1AAKCRC1SFbKvhIj
K0QkAP0eR9cEPryA2x+IYRDR8FXE90r5QvhWhohD8jKEagih1AEAlBK3gRZN7Z+z
jCnv2ybWps4ZW+XReDxJQqiXk7ydqwo=
=P23b
-----END PGP SIGNATURE-----

--v/w0JJUH87vcSvz3--
