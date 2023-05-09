Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD46FC84E
	for <lists+linux-iio@lfdr.de>; Tue,  9 May 2023 15:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjEIN6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 May 2023 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjEIN6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2023 09:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783122D78;
        Tue,  9 May 2023 06:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D40F645EA;
        Tue,  9 May 2023 13:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC32C4339E;
        Tue,  9 May 2023 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683640693;
        bh=hKYOb1Y6uVSCJFo5Pe7rnYRyoRJeFAculEqB99V3fG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUDdRjUwCMStnBHKNgEoctZUg/8V/fPvnUrT8oHNoPqhxUIQihZMdi2rJXfqvFxDY
         RaMbBhsVwgqTrRRfAeExMJ31+99qfUudMjrsVsufel85UGlw1NFk3HeFfrH1EezaUd
         qt+QVZw6HO8PZosSm2CRPrhiU3mKsgvhveus3mSI=
Date:   Tue, 9 May 2023 15:58:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit <INV.git-commit@tdk.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp reset
Message-ID: <2023050924-vegan-snooper-cddc@gregkh>
References: <20230503204410.165035-1-inv.git-commit@tdk.com>
 <20230506191017.659b5196@jic23-huawei>
 <FR3P281MB175745F6D7149F6D9F488496CE769@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR3P281MB175745F6D7149F6D9F488496CE769@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 09, 2023 at 10:27:31AM +0000, Jean-Baptiste Maneyrol wrote:
> Hi Jonathan,
> 
> the signed off is for the email address we are using for sending email to the mailing list.

Please read the documentation for what Signed-off-by: means, it is NOT
for email aliases, it is a legal statement.

Please remove it when you resend.

thanks,

greg k-h
