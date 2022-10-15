Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458F65FFA5E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Oct 2022 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJONwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Oct 2022 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJONwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2022 09:52:33 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5842552E7F
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2022 06:52:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h10so4947164qvq.7
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2022 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IhZYzWVwR6ANl8TItLFCTVvc5l7VLrZkeg3Uh0Vbwyk=;
        b=gsjfNn+p6OnKCF8XLHUC8jZQIRjKKFC+ezopPuukFVENvDNMRrxNaqyL87rpJtxuiA
         wQlRQ/1FivQJHBZuF45/PUxNnkLU5a3WR6eTF24bPjiroRN7naT0mq+V8y2hwSC9TOI6
         Xd3m5b6uIiVgmVXCy/stFocisGqd9d1s/x10fK5KtVhJ73s9cbt1hH2+FeDl6eU/ngd0
         iSE9WUwtXrOLvYiw5nYSMt4fJ1hg+oZdI4ldQ6VqQ0ita1Ql8KOwMScHt1kzoWnQ6/1l
         EFXYczKrEpDNGkoGf2Ul4Rex4AXF0ys2Be/sHZLFatIVN9b9/kkMSv6p2KjNlZGrW6Pu
         c91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhZYzWVwR6ANl8TItLFCTVvc5l7VLrZkeg3Uh0Vbwyk=;
        b=vsv0bhNcvXdGIl/rGvGZe+3Di3a0FisPXFmdbWAtqYiA7TFdsNI6DaN4QtdTK0S3gu
         sfqruo/eY4A6uJZJFAKh6mhcVsNl8zOG1Y43iPIt9OjDR/YSv38VXJKwwog5VBSF7j6U
         Cx4R+Yo9G0QHTTwMQg3Lak3cxDQgtOwDCW7KwGIqHPK1T7SSH7d1QD5mbZKc7/1yuyii
         DCOhuY2R4mL4hkoR83RWn+F4qxuzt4CSaJla6GoU3V3jmf7zfKh5n1QIr/ZI2iXQbuPQ
         ZX6V+71Gqrl4WcwcZxfO1kzChcMciNqubvj5tIxwZo7Y18CcNq/0N9A9VSCfQbhSzGN4
         oIJw==
X-Gm-Message-State: ACrzQf0ImMk9Odi1e0Hbn8F5zg+F3ggqX7zKtD/CrVJAGBytND0iG3dD
        +Y4Pr5BBvc9VcQa6BGkICa7uBy3uVumQrA==
X-Google-Smtp-Source: AMsMyM6hxxmI7Q4/FtTi2vQ9QmdL87HBnnKD4IAULJIaLwwAHWL55GATer7qvk5v0YyLJ5LTiRdF+w==
X-Received: by 2002:a05:6214:ac4:b0:4af:b60f:5c7a with SMTP id g4-20020a0562140ac400b004afb60f5c7amr1950407qvi.60.1665841951523;
        Sat, 15 Oct 2022 06:52:31 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v6-20020ac87286000000b0038b684a1642sm4002250qto.32.2022.10.15.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 06:52:30 -0700 (PDT)
Date:   Sat, 15 Oct 2022 09:52:27 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     kamel.bouhara@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Handling Signal1 in microchip-tcb-capture
Message-ID: <Y0q7Gzh95nFdqdYK@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xdpWHHg+Grftu4HJ"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--xdpWHHg+Grftu4HJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kamel,

I was looking over the microchip-tcb-capture driver recently and noticed
that the code doesn't seem to account for Signal1. In particular, it
appears that mchp_tc_count_signal_read() and mchp_tc_count_action_read()
don't check the Signal id at all and just assume they are handling
Signal0. This creates a situation where the information returned for the
Signal1 sysfs attributes are just duplicated reports of Signal0.

What exactly is the relationship of Signal0 ("Channel A") and Signal1
("Channel B"); is SignalB only relevant when the counter device is
configured for quadrature mode?

Sincerely,

William Breathitt Gray

--xdpWHHg+Grftu4HJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY0q7GwAKCRC1SFbKvhIj
K5XSAP91pKrMRiRL0thwmoh+oTH7pTvGzSAMJwnNfp4R1z64ngD/f0L02GHAQ8Py
KCXvfa2xmxmNEZpahfOaZwm82LdozQU=
=EAuO
-----END PGP SIGNATURE-----

--xdpWHHg+Grftu4HJ--
