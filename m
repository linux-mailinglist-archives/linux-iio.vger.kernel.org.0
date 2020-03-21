Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A15118E419
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 20:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgCUT7d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 15:59:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39929 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgCUT7d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 15:59:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so4911200pgb.6;
        Sat, 21 Mar 2020 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GB8B3hXvLrixG0/eEEGrzhPFDoA164EX4PeTwfvh/Y=;
        b=WHlMxUIWt9GFOsul4SxdZbzfHh7zYlKO1SB5cQFO+UCJW5tM48KITFHyXRnEJR6WGp
         qRJ5J7T0/97zyveV1vQvtf2z4mUROQUwu+PfdN4NnWKRjCYL9sfFrgYQPVFJ5mBgHAoR
         PtE2fZBxkn008CSzKZUAugr5qPfe07C7cvSgZffLyTroB+hSwXfNjpyNqV36v2Otya7S
         v0hFf/iyIHM2yhD/f5Eu+OvauwgcRqnJd99deiHPoNAAR7q6Ejc6z38JyqTkWdAQBVwh
         6ts7OlC9KXHIGVXHQoaIzL1qdIwqIvL2nfT/h45BJXF9LRy5NNjxsvyVDnhuxcW10UvG
         buJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GB8B3hXvLrixG0/eEEGrzhPFDoA164EX4PeTwfvh/Y=;
        b=W0NH3phaVB/zO7SWryzMBOwnFW1pkRp+teNKnA0oTKkzI0lE7i8kzoQvNQ/1UE3NGK
         Q0s7sukF1WauqDb/XubphjRa6V5Jkjybz9s/MZs4pZ7ZuOuoofCqtvEyn/HVpLFjW6NK
         SeZCLhn6I8Bhc0d8yQn7ufJow4XMHVMiwhIPRMcSWugtRr/56ZY/13GLyiQ17ft5ueGp
         3Af7Jg9Dpy2IPbNEDALlmSn4EgSdabJH8zaJfKdZTWO48qQhfYm8M/EkXt0GfI7VLiXM
         Z322+cnZsuPE5nfp9TAACgDR1Oke90ZfelIWru6zeQNJUQMsiEDVjoj/Pop7UqTXIN5d
         B2ig==
X-Gm-Message-State: ANhLgQ2h6Zf7g9l6Qx8YNRaeU4nDpLQQIsuy5CjfShGomZ5/3zOnIKWG
        HTGL8rxLdJxO3zCGkM1O+ZXX+pk2V7vbKJ/beQc=
X-Google-Smtp-Source: ADFU+vsqaKrYFn2wQ+0rxTXNK55h2zW7WiYm1hvNa4ptmNMMRytvTCef0I/UszdLw5xbAbNUqC6OIUeBi0WzfoiiN38=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr16030512pfj.130.1584820771967;
 Sat, 21 Mar 2020 12:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200320081257.GA5818@syed.domain.name> <20200320133522.GA3223@icarus>
 <20200321182312.57a93f88@archlinux>
In-Reply-To: <20200321182312.57a93f88@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 21 Mar 2020 21:59:20 +0200
Message-ID: <CAHp75VdO_aA79i-4ZcyasqSwFq8fyEQPnOAhEH=oM8qRFScn-Q@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: Add Syed Nayyar Waris to ACCES 104-QUAD-8 driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 21, 2020 at 8:23 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 20 Mar 2020 09:36:00 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > On Fri, Mar 20, 2020 at 01:42:58PM +0530, Syed Nayyar Waris wrote:

> Applied.

Jonathan, JFYI: we have parse-maintainers.pl which would be nice to
run when changes to MAINTAINERS happen.

P.S. This change is probably okay, but for the future.

-- 
With Best Regards,
Andy Shevchenko
