Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3684641DA5
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 16:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiLDPbb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 10:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLDPba (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 10:31:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B315A22;
        Sun,  4 Dec 2022 07:31:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D69B6B80184;
        Sun,  4 Dec 2022 15:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C05C433D6;
        Sun,  4 Dec 2022 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670167886;
        bh=HBg8TSFzV0yz0mWLK3W3gMprxAOJN/By4+fDpc0t1Es=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OY4ShmAR1vD/rSuVE221e/Rrq4iGpgxBvheFV5WpepelePy5q8VJ45V14YnyyKPBL
         PJ74/z2mkyfdpRH8r+CLLQiMrFonf4sBl1g8H4Y/0IBNeiTK2kplEBHSjdKLNWumXL
         qxhBdKR4vzXy9P3Qr2PhvYLnv97dYfquDiwHNKCvPvAmoizt36cWwdy9GGU7KZ/2hO
         Wh6YsNE4HhOj4Bv9nYxSOBmWLljm53D2Z74sQN7KdRteKsMYd8d9/hV4bqfs/BWYqA
         OXNR1Gw36llNlpFfsoXqzeiM3cV5zX4HfKcW8zYIbLFleIX8r+2HHKsQ/DQd31c1y4
         dXDBs3Pmpg//A==
Date:   Sun, 4 Dec 2022 15:44:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Fabio Estevam <festevam@gmail.com>, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: ad5686: Add an entry for
 AD5337
Message-ID: <20221204154412.4bae1e5c@jic23-huawei>
In-Reply-To: <0b2f414d-57a0-a427-3421-1ba8331459d9@linaro.org>
References: <20221130182632.3856675-1-festevam@gmail.com>
        <0b2f414d-57a0-a427-3421-1ba8331459d9@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Dec 2022 11:39:38 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 30/11/2022 19:26, Fabio Estevam wrote:
> > AD5337 belongs to the same family as the AD5338.
> > 
> > The difference is that the AD5337 has 8-bit resolution instead of 10-bit.
> > 
> > Add a compatible entry for AD5337.
> > 
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>  
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Series applied. Note this is now 6.3 material unless we end up with an rc9 for
some reason (which is very unlikely).
Until I can rebase the tree on rc1 this will just be pushed out as testing
for 0-day etc to poke at.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

