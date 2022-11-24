Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5C8637F79
	for <lists+linux-iio@lfdr.de>; Thu, 24 Nov 2022 20:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKXTO4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 14:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKXTOs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 14:14:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB39E1204;
        Thu, 24 Nov 2022 11:14:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7A9EB828CB;
        Thu, 24 Nov 2022 19:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E439EC433C1;
        Thu, 24 Nov 2022 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669317271;
        bh=Ix8+P7Duczx/NjwDDYp7hN9nqdH0RXpYRoK993t8pps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J+554nGU5qJQ8g751un1+LO0aKSS1XjaxvpxXtKZjq8pRMZpBzouvsCORUguLGxE2
         smrlFUZPfssZ9ggUwZRzAbhc3EIt8qEWRmo1iSqTF3mAM1QCgl37SBvGuBcp6vogBC
         DdcWYmvaOOFzofADwmtaCLYfQt9lzz4pu0NL1H9c1RSYyNRDwgz2uf2F0/o6JcvgmV
         /TeL0njVAfl5/m5pCE0qyUDc18w0mxETcNIYD4/vZNotXQGtXbmU5/8/VXqeu0hybn
         k9Q6LGr684uh2L9oH3i8DGQxZld5WvWDg2JDgdr9lv1Jb8dwS4YZUhTJ9n6k3v8+12
         Oydl1w6srMzNg==
Date:   Thu, 24 Nov 2022 19:27:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     mario.tesi@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 0/2] add support for ISM330IS
Message-ID: <20221124192705.1cc85674@jic23-huawei>
In-Reply-To: <cover.1669279604.git.lorenzo@kernel.org>
References: <cover.1669279604.git.lorenzo@kernel.org>
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

On Thu, 24 Nov 2022 09:49:26 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support for ISM330IS IMU mems sensor
> https://www.st.com/resource/en/datasheet/ism330is.pdf

Looks safe enough for a very late application in the cycle as it'll
get only a day or so in next before I send the final pull request.
Applied

> 
> Lorenzo Bianconi (2):
>   iio: imu: st_lsm6dsx: add support to ISM330IS
>   dt-bindings: iio: imu: st_lsm6dsx: add ism330is
> 
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>  drivers/iio/imu/st_lsm6dsx/Kconfig                        | 4 ++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 8 ++++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
>  6 files changed, 23 insertions(+), 4 deletions(-)
> 

