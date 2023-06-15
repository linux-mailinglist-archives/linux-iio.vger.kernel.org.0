Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A11731626
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jun 2023 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245666AbjFOLIc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jun 2023 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbjFOLIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jun 2023 07:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5BE271F
        for <linux-iio@vger.kernel.org>; Thu, 15 Jun 2023 04:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E7FF61E8B
        for <linux-iio@vger.kernel.org>; Thu, 15 Jun 2023 11:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A25CC433C8;
        Thu, 15 Jun 2023 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686827308;
        bh=CunC5veWNN+Q3FsAQk57mSIZ5yZPEAHdAx4MeEiL7FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAmNqQ6O6f0kcVfgYOkSbcC3aTQCIIhkw2Tl67OqhbViKuaMFdLexaRUOJVsHyHIn
         dAoATbBnJNkA4UAo0IDMzB+xi8qr23TsY/3uM+P6XIJjwhtRh0VKYylH6OWUzdQdUV
         cyZJ1UZW+xgIWDI9o1Dyg5JFngtTeKC0QT92f4RM=
Date:   Thu, 15 Jun 2023 13:07:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org, william.gray@linaro.org
Subject: Re: First set of Counter updates for the 6.5 cycle
Message-ID: <2023061513-sierra-stunned-19fc@gregkh>
References: <ZIijEjyxqt3g6tpj@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIijEjyxqt3g6tpj@ishi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 13, 2023 at 01:10:42PM -0400, William Breathitt Gray wrote:
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.5a

Nit, you forgot a '[GIT PULL]' in the subject line, almost missed this
one...

thanks,

greg k-h
