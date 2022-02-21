Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9224BE559
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350243AbiBUQ7o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 11:59:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354671AbiBUQ7k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 11:59:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745DF237CC
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 08:59:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25354B815B0
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 16:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D74C340EC;
        Mon, 21 Feb 2022 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645462754;
        bh=6CVgmiY7pPf4nJaiQxryCPp9LffV6M/FbXGwOk3+4yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdfyMPfU6mMPr9FP7/WrgLLeupeziHPN+Xn65jsVnfgGLCOtn2/UWJK8HOorJYkZz
         Rw+8oqsXMhp8IIDTsoEy2rAfJuBbO7Uzz9tIV0DGbWr90Q0X2Ajbj9okg8hcmRcaT3
         6L6fNoJzpj75IjlKLn2BKL+lLEK6v6rq/SF1BsEs=
Date:   Mon, 21 Feb 2022 17:58:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 5.17
Message-ID: <YhPEx/XzQrQQx61l@kroah.com>
References: <20220220184205.4eb4ef85@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220184205.4eb4ef85@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 20, 2022 at 06:42:05PM +0000, Jonathan Cameron wrote:
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> 
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.17a

Pulled and pushed out, thanks.

greg k-h
