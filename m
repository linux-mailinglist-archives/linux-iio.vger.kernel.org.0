Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2623B7B50F6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Oct 2023 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjJBLOu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Oct 2023 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjJBLOu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Oct 2023 07:14:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5C3DD
        for <linux-iio@vger.kernel.org>; Mon,  2 Oct 2023 04:14:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2BCC433C7;
        Mon,  2 Oct 2023 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696245285;
        bh=1ctW2xfUdv9GmDRs2Sj6Jo9kcU21YqRZkyliBB6Wnog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kroFJKZ4iGQVzQHXBCwuvpARKcB0mg8FyCZ0cYPixCWWuJ00TgtbSWi7iX3mr+Tou
         YGcuJN2JouRc69oi4WW3gAfnY/xyKyrcDvIognwKZbmoqtCu91uiM7JFwAz32tU9Qk
         +uSfqu945O9XVzL6mzSFPWL7i53j31Ir5tXa53Wg=
Date:   Mon, 2 Oct 2023 13:14:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] First set of Counter fixes for 6.6
Message-ID: <2023100228-mundane-ripeness-526f@gregkh>
References: <ZPpPl8V97juxRNyT@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPpPl8V97juxRNyT@ishi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 07, 2023 at 06:32:55PM -0400, William Breathitt Gray wrote:
> The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:
> 
>   Linux 6.5 (2023-08-27 14:49:51 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.6a

Sorry for the delay, pulled and pushed out now, thanks.

greg k-h
