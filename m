Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F103D6C1278
	for <lists+linux-iio@lfdr.de>; Mon, 20 Mar 2023 13:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjCTM61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Mar 2023 08:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjCTM57 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2023 08:57:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74D02106
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2023 05:57:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D5F5B80DD3
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2023 12:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5BCC433EF;
        Mon, 20 Mar 2023 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679317058;
        bh=IACcB8dypFQCyo15WqsoPfRlXH/E5MQkesKzKb6GI2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLHyTH1XTqWnd0/OpUSW8tajOSlgkbfWdxF/dIF24DJZxfsUDjDyQBsjn7gUGaLAu
         9IdI+C1MXT0rgA8bVEnum4DWVze5P6u7DgQV8+GFUsAb/J19fqujCsJPQ9iJl3isvc
         t35T2fCzh+Qt7w8g5EyRsEU3ZKXpp08p4lFOq11s=
Date:   Mon, 20 Mar 2023 13:57:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org, william.gray@linaro.org
Subject: Re: [GIT PULL] First set of Counter driver fixes for 6.3
Message-ID: <ZBhYPiKxhHDnmFQQ@kroah.com>
References: <ZBXGb2rwkcGtkArk@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBXGb2rwkcGtkArk@ishi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 18, 2023 at 10:10:55AM -0400, William Breathitt Gray wrote:
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-6.3a

Pulled and pushed out, thanks,

greg k-h
