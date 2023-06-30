Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858A47433F7
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jun 2023 07:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjF3FNx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jun 2023 01:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjF3FNw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jun 2023 01:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E71319AF
        for <linux-iio@vger.kernel.org>; Thu, 29 Jun 2023 22:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9270A61646
        for <linux-iio@vger.kernel.org>; Fri, 30 Jun 2023 05:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEEBC433C0;
        Fri, 30 Jun 2023 05:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688102030;
        bh=ygsfnNvkDPOnp5olYNMlXhLplV7waio0+Vt0yiqXPz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvGMFTXYOIjE/svvhgW2v0e5qYy7qgpejgYVpiGz/VKT1isnJQfy4de/DQqQGjf1a
         KBWWQF2+gw/tugTxG2lW9NVQ47V//EDr2Lv988FJJBgIRYytaX+frdJOoAf4rhlduJ
         eHcja9Pa0y4lSBi7FMtkHe7N3iWInf5BCQpf1aB98fqAhw46eOvSmZ6oSGZNj5SgcT
         +m1EC2xuUol70ZwEC0q2G2uK/tcMX/xFVpP/G5fmYml2yl+X2/zcqP5a1Otk82jwXt
         6kHrjo9jjhOzMV65sTVRrdazD+JwJaeOTtDdw57nPHBqJVuJaM53NprHbLm1oUMRtO
         BoG/jgKcTSvZw==
Date:   Fri, 30 Jun 2023 13:13:46 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Yiyuan Guo <yguoaz@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, bleung@chromium.org,
        groeck@chromium.org, dianders@chromium.org,
        mazziesaccount@gmail.com, gwendal@chromium.org,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH] iio: Fix the allocation size for cros_ec_command
Message-ID: <ZJ5kiiuhITCpqwrn@google.com>
References: <20230629132405.1237292-1-yguoaz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629132405.1237292-1-yguoaz@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 29, 2023 at 09:24:05PM +0800, Yiyuan Guo wrote:
> The struct cros_ec_command contains several integer fields and a
> trailing array. An allocation size neglecting the integer fields can
> lead to buffer overrun.
> 
> Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>

Better prefix the commit title with "iio: cros_ec:".

With that:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
