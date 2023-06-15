Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39587731621
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jun 2023 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245603AbjFOLHa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jun 2023 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjFOLH1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jun 2023 07:07:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7AD271F
        for <linux-iio@vger.kernel.org>; Thu, 15 Jun 2023 04:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6E962082
        for <linux-iio@vger.kernel.org>; Thu, 15 Jun 2023 11:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBF7C433C0;
        Thu, 15 Jun 2023 11:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686827238;
        bh=9aEMx/oRc+MOBFt6UJgKVWjgTIUaSEkgiNQw2o0m+Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9UEwooKDsjnAOet2Rv/K5CmUkie/hM1JXIyN+Nt1r3kYQ+HrfXUdZCL4OTdfsYuM
         JLQtg14cKri1c90oanwdn6tRoqvcTX0Z/sPG0Yx/iEFG0nSMoCXEQoko9qWVdNcQep
         +lmKeO/OuMHe8oa6rOZAEnvv5DYqm9zr77D6AixY=
Date:   Thu, 15 Jun 2023 13:05:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of new device support, features and cleanups
 for 6.5
Message-ID: <2023061536-passage-unshipped-c0c9@gregkh>
References: <20230614080900.1fe702f4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614080900.1fe702f4@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 14, 2023 at 08:09:00AM +0100, Jonathan Cameron wrote:
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.5a

Pulled and pushed out, thanks

greg k-h
