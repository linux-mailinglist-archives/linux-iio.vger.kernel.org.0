Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0E767EB8
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jul 2023 13:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjG2LbZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Jul 2023 07:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjG2LbY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jul 2023 07:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99D186;
        Sat, 29 Jul 2023 04:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30C860BA7;
        Sat, 29 Jul 2023 11:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295E5C433C8;
        Sat, 29 Jul 2023 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690630283;
        bh=D7BHX23SFdFVwODoZPxwe88r4XDBlyGO1Soe3tBGSaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANcyXe9Tin32nMS8kqWc3SZL38UVr8CbaI2TmCQejh4Ak7ad8X0ZlWA1CQ4vSBf26
         Z0/yIZh/O1uprAc4zET1VLotuvuTeup4/mnc4AWeI5MyhuOE/X4JnSqDODy3Xz9ybS
         Dj8SAmmkZOhsSrCVHtXn4a/tjf9wlC+o0XNe+SDHqbN7nb1ACVreaJVNXq7JCOS8nH
         gkEO06Uxm6Vkf347chfGfT9Y7YfRVPFhCsRH91tpjJzAcBp06DDEWHo6cO5OEY6IMJ
         AbzMX2nVlGGt8+sA7SwiE2+9UeAIuu1CN8Ya/caAumjibtVssFlTXpD8cqjUGheTBN
         V5hlSsDHaxyRA==
Date:   Sat, 29 Jul 2023 12:31:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        George Mois <george.mois@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Use i2c_get_match_data() instead of
 device_get_match_data()
Message-ID: <20230729123126.58e48812@jic23-huawei>
In-Reply-To: <20230725171624.331283-1-biju.das.jz@bp.renesas.com>
References: <20230725171624.331283-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jul 2023 18:16:22 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Use i2c_get_match_data() to get match data for I2C, ACPI and
> DT-based matching instead of device_get_match_data() the one for
> ACPI/DT-based matching.
> 
> This patch series is only compile tested.

Even though one of these is a fix I'll take them the slow route
to avoid having to hold on to the second patch.

Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Jonathan

> 
> v2->v3:
>  * Added Rb tag from Geert for patch#1.
>  * Added link to lore for Closes tag.
> v1->v2:
>  * Added patch#1 for fixing adxl313_i2c_id[] table.
>  * Added Rb tag from Geert
>  * Removed error check as all tables have data pointers.
>  * retained Rb tag as the change is trivial.
> 
> Biju Das (2):
>   iio: accel: adxl313: Fix adxl313_i2c_id[] table
>   iio: accel: adxl313: Use i2c_get_match_data
> 
>  drivers/iio/accel/adxl313_i2c.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

