Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B6543FEA
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiFHXhY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 19:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiFHXhY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 19:37:24 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2615EA7D
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654731437; bh=IthwOWtut8eNzphZdaRNmlsrtBV6Zy9c1bkP/Ub7F7Y=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=hYIG5gFYce5WCEaVWEXDeuakq1+aJ6b0tDhCtEzdzNH+tTqJZ7dHHTo0Y785yIqFWPoTvt70dtg22cKXcQIdS8ckPorr04UZrXECT8bRjO/C9X+27143umABgEunco+iEEvBst5Isc6gW1k0G3tMKiIcfJOuR8doARkvlhyNhwqfYRFQVJpQcJjB7QXCk5Iq5YvS0mTeN1QPUxKB4VoS1EdxM1BKzNyolpmA5rUp+VduogImorpLIlqrumKbJSwmAIw8ooKXdN7cQ35SzvFukYUxY5z+OgSCypaU4OZb1CXxs/tshXFNxH0BYopzGKMIaJQB5oeqRyRvUwfu+vpulA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654731437; bh=aBEtew+ZViLJ7xsW58Wz+PFVwRlCj8hx8kklRKbQHOU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Kj/+LggP6CDF5ZS/F5Q4+AVd+evzNNY50QTPODTINh+ZVG5DwlZX/sD6jXJG601KPxyzHMtgtVJoGE+z+1kqj8hKsh4wwfwciAgSRcORwQILu1EqDZ/uP988pNM5/HLAY1J7Mvj91XwhQznHpk3fkw7mJzHLBKsJNtvszpCVNjuYBxfbLxSJ/6Ysgi1Z/ifpkujXPDsBiTv6XikinT7utEAkE3N+OFrEuL1h0HIal9Kmhov1p53IpVcVHWBQmIJT0wsu6+FoLlHI7RmxHy9eaZp4TqzJPLfhuBCZI+esWdbWvtq0NUwsuc5irG1xsKcGsuk4LnON4NZv0aDqTfb+2A==
X-YMail-OSG: hXRkoDIVM1n032uFQi_8LTLnD4QRr_FApxYaBMx8Cfmo_0pNAWTp6Rze0qMFqdV
 3nWb63BCbXlQHIOo21Rmmx6R3f3xcvgUMb.FtdmsHNBUTgj7.pjG96Qx3JPHWHs04sMMndO9e6..
 a50OzR4MwThZIObgdTDS..lgmyMtv7TEu5kRtBEvYQxO33Qdj2z2Bq2bDxPNKnT4hA2ymGtPXbqt
 pLQxWG_tYYW5uElIU_VWi7Jx7gWxJC1Ne47xtw1HvM3_s4OXM0EXr2PZjuWC_lKrnjHugVM1iJrO
 bWupRhgyCIMbbxI0de_0.jR1.YokGPD.4to9WfMpDLki9m5.nXPN5gRjLjQPQEqtor3z0LeG8sIM
 nhr4OhDQVVYdMo3ItmuqNZqtIG5jFrVLTyqhgWdfpj6L54HZ0bUIIle_7_6VA_N4AS0OEqEXbsOS
 mxP4zr1L7SFjCb7vBPpKpKeLqcPsJp4nYjaQXYfufKYrSqJq7eu34Onu2PWn9LOHjQCy7eUJdE6e
 oh.YfLor.G.rNKSLTsjmE5JFRLWCNili24QLNuw59htf8_uuGrsoCdLNvgbcAEnOTtskrQrgvDYJ
 3P7pccMOTAjQpXVriFkJiPvh4VQpYwyWpeCs2YLMQSlWg5uk0wIkpAoZXXtYfp.gfoaJxWEiiLxm
 DUFgw96PMBg4HrQkLQXqOulV7Cqj8YiODg9P7YFcEYKycMHUozzaL4oIX0Cfg.Se4Yc2TZ6aXGp0
 U9_4NUmksqR8nTqg0cSrpxCmk.mrfq5iE.mD48y.DiwAbbIm8PXi7vucFvZUmxrljSZHqfaug3au
 pC.8m7QuhRf9b61IBdUa0pi33wTHk2YEd8DpWk184t0O16ffKJKoZckX9Bg4bJD1g.hOV8lxw7_T
 Epe7hcjEiKtfFqrtckPewvNTcQi7j_Up4uQ0_7b_fd.piC_CjYyD2ZGZDiZQc7RkS8RQgGiEqffM
 Y7p_shxKoZobROkvqlChxgtVfAGkAaXBtobvFTzlIOJMWTHwi8K1CfbF267zx8a5GB8zGvYEjiHl
 9pEesueA4aM3VznPYyXsI6xopnicvRFqs9974IfWJ3syRSjvjpVbyEds8.hdyhI1URiFSvcBfA3m
 cb05nAmRcq2u.bA6_ogeoTdAFYJ6SUIl3lqZtHlUr1R4wnnRrAdCtHjkdN5H9YOAinplLQ4I0sfO
 vKrdCaTid4H77_WHZ9gkUpk2wnkhJB5h50J92aWGE3PihahcW.NCh4ql5J.9PfRudhvw6TDDX6NQ
 2bohWSzL5YEHyfLFp7vP95klDsI.bC9oFg.tynfmAfYY7pLRAuMZOiBhnIVDtWnAO1FJ7idZ1eak
 ttPq0STIIgT4EnXxWZb6yHSgaEjo7zdSX_gWf1D75AfsmfNQoYD1hUe9cpWT1EAch7GieEyBpDnl
 HNMXOwyocFiaiVl77UC3a3iN7T3KhGZv2mtI7hcn8L9ZEgogHArDaxFQl2zhclZ7g5F5rsWTv.RJ
 JhNHfzMbi0NoOIN15WlzmAQxp69nozpq2YmUhm1NUaBMzS8s6uBQnIZEk6rY3nkHMIoq3oqPEVzh
 _9UGMs80MsO5Ud72owlLwueIvZOhiyOZbnYIAL38JM0XdCzt6bjOdr7ZSsrUTP.7ivrYSnlXT_Xs
 USBKhQFPGtdE1ZfJWS.oxxW4sp8XQafG3BI2Nde2U7RK.UZa3HCtEd1tOSp6Ne7ERv6KJI0lJOuh
 rOK4RNAzCADkHRrq4LjZRI3tRLlghZ5t_buCniMTmOKaJrnKLVlC3Ms5a0usDsYHYgdMMcmBmQne
 tTLL88qtsuy9otSUywzSRuj6kSZszfV6Vdu6pZJhreq6yI1nEpRVf4YZWIc6_DlrWfN1otKwIvhl
 TMVsSryRXo.6ZzTMCJzWyOmgG_35zMkefmaxfzmbCeVsimyp7zl.PFhjCcx5TsBQQZOnm6QLMmwW
 lYaFqXpNjJRMClyUzAC0s3Fdh4jqWxj638nMd8nTmc9JAodL.AOtXOh3gPd59Fy5DBDkouO_N.vL
 gISUyAYfcXLxFy5FnXmvXkBAu1_EcchSFRDmSuDSEnkw6no5q1FZh_d7v7TBCSkuNEGm42LGtXH1
 RRQuRkwi3LsA5uoQMYfCOLNvgL5yip5oE6ntHCUaOJxb0LJwMOmHz2cxDmKZlAEr_OVbNVM2iRUq
 PVgvUUKEmp0rlp906MDTgYnWxFUJ.g9FRZ_jrjgRz2btQm6DzoX2qu6rXj8WB9mW2EpWN0Mq5xJE
 owaGlDVf_8n9qyz5Oi7dpzsI1FMY9Gi_A9dReU2v9PgDKq7k2D030wNkWmYYIlntUnKhXfoU5UbZ
 kbjUZomtnYZ0JNoE-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Jun 2022 23:37:17 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tcd7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d102cdf3c8b0c03d0e427125c318dc98;
          Wed, 08 Jun 2022 23:37:16 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 0/7] Add support for magnetometer Yamaha YAS537
Date:   Thu,  9 Jun 2022 01:36:18 +0200
Message-Id: <cover.1654727058.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1654727058.git.jahau.ref@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds YAS537 variant to the already existing driver for
Yamaha YAS magnetometers.

Patches 1-4 applies corrections that popped up when working on this.
Patches 5-6 are preparations for adding YAS537.
Patch 7 finally adds the YAS537 variant.

Jakob Hauser (7):
  iio: magnetometer: yas530: Change range of data in volatile register
  iio: magnetometer: yas530: Correct scaling of magnetic axes
  iio: magnetometer: yas530: Correct temperature handling
  iio: magnetometer: yas530: Change data type of hard_offsets to signed
  iio: magnetometer: yas530: Change data type of calibration
    coefficients
  iio: magnetometer: yas530: Remove redundant defaults on switch devid
  iio: magnetometer: yas530: Add YAS537 variant

 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 814 +++++++++++++++++++----
 2 files changed, 698 insertions(+), 120 deletions(-)

-- 
2.35.1

