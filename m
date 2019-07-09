Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B93A63639
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2019 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfGIMw3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jul 2019 08:52:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36432 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIMw3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2019 08:52:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so10068036plt.3;
        Tue, 09 Jul 2019 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+IweNL8b+xDveqKnIe4yQ0cAQMLQTrEEGoWLgF1UZaM=;
        b=VnB9rsG1ayhuLWLCiI2Rnwv/s6i6uzac1x8SOhCCmqC3du9UH4lK/dXzHM0XOtLIg7
         AuqSX/Dn6a3gGykrA7yBRXr6TpEMvCIy1GtZmiHdaBxCYLU8k881b/mOQorwhN6jjDr0
         jKF1c6xxTUcX7/Yi5DFkDP6b43EXRvSM/Q2HL8z9mSOklZDiSlRxhQ/iDUcLzxCqPnWH
         yYblC5ndnasaqB5C3i9d6NUDRYAsDRKa+x4JoJZOqAH3XABTcRMEsJc7Q9l56mOaRwjk
         H4yJ3JVMfvWzhSxkYxsy4ABxvCiylPYJ9UFlgsZDKTuP+gmTf21F5dyF/Fm2Swd9qf1h
         ziYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IweNL8b+xDveqKnIe4yQ0cAQMLQTrEEGoWLgF1UZaM=;
        b=B+Zj7bRCyPWvp6b7aBAZsjadN4BFHEJMFZM/Jwk3oS8QmtVIAA2w1rD2R463lmf+vu
         QM1nl3egn/4BIlnR8copCnZdAJQmLlWrxl8D7V1CTWJFUQIorBn437OWEUldH6lH7gHO
         6VMVZK4B77P85d04FZOgj5wlMYUibCUNKAXbiKfMQEt/raswD1Nll/ABO+A7wC9dNC3o
         r5y6U57CR5T+AHzR9/oZvxbKoYivndTAlEzakDhNEYhqiNuZeMG1c9cy/Bl630eN3zLj
         shzwprrz24pBnckoVbpXlJ+k7golAv8hxjy1pBQP4AM4jsAiSdbz1W9tHdqQaidfKYL+
         PZZA==
X-Gm-Message-State: APjAAAWJQQpkNTr2AItcAX0tbt8K81OLgbZZMu5/0+p08jFpI5Pfh9dx
        ZfdOxD96qC7n5sFfbc3rA3Vufiuk
X-Google-Smtp-Source: APXvYqw7PTSyG9r7PlsPDG2x50xcB7+tl80pu8CuoCSymahAZuOGpl5hSlURUUBlmRHfb3wyWAkAGQ==
X-Received: by 2002:a17:902:654f:: with SMTP id d15mr30174110pln.253.1562676748406;
        Tue, 09 Jul 2019 05:52:28 -0700 (PDT)
Received: from icarus ([2001:268:c145:6825:1c79:bf4:8232:d614])
        by smtp.gmail.com with ESMTPSA id v4sm6100824pgf.20.2019.07.09.05.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 05:52:27 -0700 (PDT)
Date:   Tue, 9 Jul 2019 21:52:10 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: driver-api: generic-counter: fix file path to
 ABI doc
Message-ID: <20190709125210.GA6234@icarus>
References: <20190709075436.7294-1-marcus.folkesson@gmail.com>
 <20190709110613.GA4476@icarus>
 <20190709064845.6be66cd2@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190709064845.6be66cd2@lwn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 09, 2019 at 06:48:45AM -0600, Jonathan Corbet wrote:
> On Tue, 9 Jul 2019 20:06:33 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > Fixes: 09e7d4ed8991 ("docs: Add Generic Counter interface documentation")
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > 
> > Jonathan, would you be able to pick this up in your tree?
> 
> I can apply it, yes.  But why are you supplying an SOB for it?
> 
> Thanks,
> 
> jon

I'm sorry, that should be an Acked-by line.

Thanks,

William Breathitt Gray.
