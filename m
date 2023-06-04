Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA94721647
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jun 2023 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjFDLIQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jun 2023 07:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLIP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jun 2023 07:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95683
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 04:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B60260C76
        for <linux-iio@vger.kernel.org>; Sun,  4 Jun 2023 11:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D15C433EF;
        Sun,  4 Jun 2023 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685876893;
        bh=FssBKKqiJMS+Am5oE+ADmtsIOppJwPyoNgUFyGxXQCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nEXoMaBW+eIqNZEo1XDdwma8VEMVtwGQj2YsQCGD6evyWGYagXXfTsSGgnGOCbL3x
         vPGvOzYTmp+3QCc3PLgVQx4Sx6gdpAT/JRKW68vupjkVqFASLq/bUHCRCNqk3mA9a4
         eohF0rKc7/PPWtxX0AOV9fm/rfWUE64GMKawuJbMIVo7wnAg+XTJHJLPWyIaQVMB/m
         F38v3MEMeMq/cobASfpEZ+0qpTaHgRvLXtHeK3lvpt2D0U7Use5MW60DGQ9fBFVR/V
         2es8vTg1PT7P67WCX89kZGqPvL/u4VM6FZQfDrJ7xWveB+F+LaedVKhiB7tdQLencI
         MKRo6vJAhsKLg==
Date:   Sun, 4 Jun 2023 12:08:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     inv.git-commit@tdk.com
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 4/4] iio: imu: inv_mpu6050: use the common inv_sensors
 timestamp module
Message-ID: <20230604120810.087ae732@jic23-huawei>
In-Reply-To: <20230531142513.48507-5-inv.git-commit@tdk.com>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
        <20230531142513.48507-5-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 31 May 2023 14:25:13 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Replace timestamping by the new common inv_sensors timestamp
> module.
Are there functional changes as a result of this, or were the two
algorithms identical?

I don't mind changes, but should call out if there are any when
unifying code like this,

Jonathan

> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
