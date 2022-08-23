Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624B459E3C9
	for <lists+linux-iio@lfdr.de>; Tue, 23 Aug 2022 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbiHWMdZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Aug 2022 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349111AbiHWMbi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2022 08:31:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAE8B98
        for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2022 02:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD6AFB81C63
        for <linux-iio@vger.kernel.org>; Tue, 23 Aug 2022 09:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D337C433C1;
        Tue, 23 Aug 2022 09:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247879;
        bh=zEFpJMaruP2DEoUTMcY2E8Ea2BVpq7ac2iwSHyZyP78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+qpewJLfvp2K7aG2tyMomqI7+6mGPmItU71qWDyHmDjL2uLxJTOGqo6SJsFLPgQI
         7WDPFJ41sx5DfAEmn23HJYkAMBmmB3dW6JW6dx0cXrf12yQASp8FEPtV1Nif7deoJC
         jWObGxXlawfxOPouIhxUyRzjgkrVdLFIN+MREsYA=
Date:   Tue, 23 Aug 2022 10:43:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 6.0
Message-ID: <YwSTJMJYl/pStDJT@kroah.com>
References: <20220822195558.3b4bcf5a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822195558.3b4bcf5a@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 22, 2022 at 07:55:57PM +0100, Jonathan Cameron wrote:
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.0a

Pulled and pushed out, thanks.

greg k-h
